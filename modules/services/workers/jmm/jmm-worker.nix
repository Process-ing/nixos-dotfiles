{ self, ... }:

{
  flake.modules.nixos.jmm-worker = { config, lib, pkgs, ... }: let
    cfg = config.workers.jmm;
  in {
    options.workers.jmm = self.lib.mkWebsiteWorkerOptions "jmm";

    config = lib.mkIf cfg.enable {

      # Register jmm user
      system-user-registry.services = [ "jmm" ];

      # Setup container
      virtualisation.oci-containers.containers = {
        jmm = {
          image = "jmm:latest";
          pull = "never";
          ports = [ "${toString cfg.port}:3000" ];

          podman.user = "jmm";
        };
      };

      # Add container build step
      systemd.services.podman-jmm = {
        path = [ pkgs.podman ];
        startLimitBurst = 5;

        preStart = lib.mkAfter ''
          podman build -t jmm ${pkgs.jmm-website}/share/jmm-website
        '';
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