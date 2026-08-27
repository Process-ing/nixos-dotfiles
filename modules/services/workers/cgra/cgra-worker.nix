{ self, ... }:

{
  flake.modules.nixos.cgra-worker = { config, lib, pkgs, ... }: let 
    cfg = config.workers.cgra;

    websiteFiles = pkgs.fetchFromGitHub {
      owner = "Process-ing";
      repo = "feup-cgra";
      rev = "e86d0ba50e5eab507bf1babcd27d5e9bcbd0d55c";
      sha256 = "sha256-dhJcn6kn2IhbRZS927pT2ktdTaep+QKyFfJ6rmVW+jY=";
    };
  in {
    options.workers.cgra = self.lib.mkStaticWebsiteWorkerOptions "CGRA";

    config = lib.mkIf cfg.enable {

      # Setup Nginx host
      services.nginx.virtualHosts.${cfg.domain} = self.lib.mkNginxHost config {
        locations = {
          "/".return = "301 https://${cfg.domain}/project$request_uri";

          "/project".root = websiteFiles;
          "/lib".root = websiteFiles;
        };
      };
    };
  };
}