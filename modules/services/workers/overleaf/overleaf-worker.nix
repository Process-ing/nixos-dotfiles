{ self, ... }:

{
  flake.modules.nixos.overleaf-worker = { config, lib, ... }: let
    cfg = config.services.overleaf-worker;
  in {
    imports = with self.modules.nixos; [
      overleaf-user
    ];

    options.services.overleaf-worker = self.lib.mkWebsiteWorkerOptions "Overleaf";

    config = lib.mkIf cfg.enable {

    };
  };
}