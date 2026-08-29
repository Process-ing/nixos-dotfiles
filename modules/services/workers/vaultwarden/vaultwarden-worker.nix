{ self, ... }:

{
  flake.modules.nixos.vaultwarden-worker = { config, lib, ... }: let
    cfg = config.workers.vaultwarden;

    volumeFolder = "/mnt/raid1/vaultwarden";
  in {
    options.workers.vaultwarden = self.lib.mkWebsiteWorkerOptions "vaultwarden";

    config = lib.mkIf cfg.enable {

      # Register vaultwarden user
      system-user-registry.services = [ "vaultwarden" ];

      # Declare secrets
      sops.secrets = {
        "workers/vaultwarden/admin_token" = { };
      };

      # Create environment file
      sops.templates."workers/vaultwarden/.env" = {
        owner = "vaultwarden";
        content = ''
          SIGNUPS_ALLOWED=false
          ADMIN_TOKEN=${config.sops.placeholder."workers/vaultwarden/admin_token"}
        '';
      };

      # Create storage volume
      systemd.tmpfiles.settings = {
        "10-vaultwarden" = {
          ${volumeFolder}.d = {
            user = "vaultwarden";
            group = "vaultwarden";
            mode = "0700";
          };
        };
      };

      # Setup container
      virtualisation.oci-containers.containers = {
        vaultwarden = {
          image = "docker.io/vaultwarden/server:1.37.2";
          ports = [ "${toString cfg.port}:80" ];
          environmentFiles = [ config.sops.templates."workers/vaultwarden/.env".path ];
          volumes = [
            "${volumeFolder}:/data"
          ];

          podman.user = "vaultwarden";
        };
      };

      # Configure Nginx host
      services.nginx.virtualHosts.${cfg.domain} = self.lib.mkNginxHost config {
        locations."/" = {
          proxyPass = "http://localhost:${toString cfg.port}";
        };
      };
    };
  };
}