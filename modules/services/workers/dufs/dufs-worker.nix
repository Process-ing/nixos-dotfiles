{ self, ... }:

{
  flake.modules.nixos.dufs-worker = { config, lib, ... }: let 
    cfg = config.services.dufs-worker;
  in {
    imports = with self.modules.nixos; [
      dufs-user
    ];

    options.services.dufs-worker = self.lib.mkWebsiteWorkerOptions "dufs";

    config = lib.mkIf cfg.enable {

      # Declare config secrets
      sops.secrets = {
        "workers/dufs/username" = {};
        "workers/dufs/password" = {};
      };

      # Build config
      sops.templates."workers/dufs/config.yaml" = {
        owner = "dufs";
        content = ''
          serve-path: 'data'
          port: 5000
          auth:
            - ${config.sops.placeholder."workers/dufs/username"}:${config.sops.placeholder."workers/dufs/password"}@/:rw
          allow-all: true
        '';
      };

      # Setup container
      virtualisation.oci-containers.containers = {
        dufs = {
          image = "docker.io/sigoden/dufs";
          ports = [ "5000:5000" ];
          volumes = [
            "${config.sops.templates."workers/dufs/config.yaml".path}:/dufs/config.yaml"
            "/tmp/dufs:/data"
          ];
          cmd = [ "--config=/dufs/config.yaml" ];

          podman.user = "dufs";
        };
      };

      # Setup Nginx host
      services.nginx.virtualHosts.${cfg.domain} = self.lib.mkNginxHost config {
        extraConfig = ''
          client_max_body_size 100M;
        '';

        locations."/" = {
          proxyPass = "http://localhost:${builtins.toString cfg.port}";
        };
      };
    };
  };
}