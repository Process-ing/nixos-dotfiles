{ self, ... }:

{
  flake.modules.nixos.sgi-worker = { config, lib, pkgs, ... }: let 
    cfg = config.workers.sgi;

    websiteFiles = pkgs.fetchFromGitHub {
      owner = "Process-ing";
      repo = "feup-sgi";
      rev = "fad42f10894023b119c6ce3ab77be8c52fbfe586";
      sha256 = "sha256-MFyjczWIr0b+cWGG3Rklfag7ZQDC20GJ4fVJZfcZvcg=";
    };
  in {
    options.workers.sgi = self.lib.mkStaticWebsiteWorkerOptions "SGI";

    config = lib.mkIf cfg.enable {

      # Setup Nginx host
      services.nginx.virtualHosts.${cfg.domain} = self.lib.mkNginxHost config {
        locations = {
          "/".return = "301 https://${cfg.domain}/pw2$request_uri";

          "/pw1".root = websiteFiles;
          "/pw2".root = websiteFiles;
          "/lib".root = websiteFiles;
        };
      };
    };
  };
}