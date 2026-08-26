{ self, ... }:

{
  flake.modules.nixos.jmm-worker = { config, lib, pkgs, ... }: let
    cfg = config.services.jmm-worker;
  in {
    options.services.jmm-worker = self.lib.mkWebsiteWorkerOptions "jmm";

    config = lib.mkIf cfg.enable {

      # Register jmm user
      system-user-registry.services = [ "jmm" ];

      # Create build service
      systemd.services."podman-jmm-build" = {
        description = "Build service for jmm worker";
        path = [ pkgs.podman ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          User = "jmm";
          Group = "jmm";
          TimeoutStopSec = "600s";
        };

        script = ''
          podman build -t jmm ${pkgs.jmm-website}/share/jmm-website
        '';
      };

      # Setup container
      virtualisation.oci-containers.containers = {
        jmm = {
          image = "jmm:latest";
          pull = "never";
          ports = [ "${toString cfg.port}:3000" ];

          podman.user = "jmm";
        };
      };

      # Ensure image is built before launching
      systemd.services."podman-jmm".after = [ "podman-jmm-build.target" ];

      # Configure Nginx host
      services.nginx.virtualHosts.${cfg.domain} = self.lib.mkNginxHost config {
        locations."/" = {
          proxyPass = "http://localhost:${toString cfg.port}";
        };
      };
    };
  };
}