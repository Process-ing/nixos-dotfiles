{ self, ... }:

{
  flake.modules.nixos.sgi-worker = { config, lib, ... }:let 
    cfg = config.services.sgi-worker;
  in {
    options.services.sgi-worker = self.lib.mkStaticWebsiteWorkerOptions "SGI";

    config = lib.mkIf cfg.enable {

      # Setup Nginx host
      services.nginx.virtualHosts.${cfg.domain} = self.lib.mkNginxHost config {
        locations = {
          "/".return = "301 https://${cfg.domain}/pw2$request_uri";

          "/pw1".root = "/srv/sgi";
          "/pw2".root = "/srv/sgi";
          "/lib".root = "/srv/sgi";
        };
      };
    };
  };
}