{ self, ... }:

{
  flake.modules.nixos.overleaf-worker = { config, lib, ... }: let
    cfg = config.services.overleaf-worker;
  in {
    options.services.overleaf-worker = self.lib.mkWebsiteWorkerOptions "Overleaf";

    config = lib.mkIf cfg.enable {

      # Register overleaf user
      system-user-registry.services = [ "overleaf" ];
    };
  };
}