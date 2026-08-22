{ self, ... }:

{
  flake.modules.nixos.cgra-worker = { config, lib, ... }: let 
    cfg = config.services.cgra-worker;
  in {
    options.services.cgra-worker = self.lib.mkWorkerOptions "CGRA website";

    config = lib.mkIf cfg.enable {

      # Setup Nginx host
      services.nginx.virtualHosts.${cfg.domain} = {
        forceSSL = true;
        root = "/srv/cgra";
      };
    };
  };
}