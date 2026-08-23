{ self, ... }:

{
  flake.modules.nixos.cgra-worker = { config, lib, ... }: let 
    cfg = config.services.cgra-worker;
  in {
    options.services.cgra-worker = self.lib.mkStaticWebsiteWorkerOptions "CGRA";

    config = lib.mkIf cfg.enable {

      # Setup Nginx host
      services.nginx.virtualHosts.${cfg.domain} = self.lib.mkNginxHost config {
        locations = {
          "/".return = "301 https://${cfg.domain}/project$request_uri";

          "/project".root = "/srv/cgra";
          "/lib".root = "/srv/cgra";
        };
      };
    };
  };
}