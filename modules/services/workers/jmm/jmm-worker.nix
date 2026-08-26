{ self, ... }:

{
  flake.modules.nixos.jmm-worker = { config, lib, pkgs, ... }: let
    cfg = config.services.jmm-worker;
  in {
    options.services.jmm-worker = self.lib.mkWebsiteWorkerOptions "jmm";

    config = lib.mkIf cfg.enable {

      # Register jmm user
      system-user-registry.services = [ "jmm" ];

      # Configure Nginx host
      services.nginx.virtualHosts.${cfg.domain} = self.lib.mkNginxHost config {
        locations."/" = {
          proxyPass = "http://localhost:${toString cfg.port}";
        };
      };
    };
  };
}