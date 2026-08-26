{ self, ... }:

{
  flake.modules.nixos.cloudflare-ddns-worker = { config, lib, ... }: let
    cfg = config.services.cloudflare-ddns-worker;
  in {
    options.services.cloudflare-ddns-worker = self.lib.mkWorkerOptions "Cloudflare DDNS";

    config = lib.mkIf cfg.enable {

      # Register cloudflare-ddns user
      system-user-registry.services = [ "cloudflare-ddns" ];

      # Declare secrets
      sops.secrets = {
        "workers/cloudflare_ddns/cloudflare_api_token" = { };
      };

      # Create environment file
      sops.templates."workers/cloudflare_ddns/.env" = {
        owner = "cloudflare-ddns";
        content = ''
          CLOUDFLARE_API_TOKEN=${config.sops.placeholder."workers/cloudflare_ddns/cloudflare_api_token"}
          DOMAINS=processing.pt,dufs.processing.pt,vaultwarden.processing.pt,cgra.processing.pt,jmm.processing.pt,overleaf.processing.pt,sgi.processing.pt
          PROXIED=true
        '';
      };

      # Setup container
      virtualisation.oci-containers.containers = {
        cloudflare-ddns = {
          image = "docker.io/favonia/cloudflare-ddns:1.17.0";
          environmentFiles = [ config.sops.templates."workers/cloudflare_ddns/.env".path ];
          user = "1000:1000";
          extraOptions = [
            "--network=host"
            "--cap-drop=all"
            "--security-opt=no-new-privileges:true"
          ];

          podman.user = "cloudflare-ddns";
        };
      };
    };
  };
}