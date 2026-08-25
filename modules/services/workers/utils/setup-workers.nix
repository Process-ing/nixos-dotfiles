{
  perSystem = { config, pkgs, lib, ... }: let
    cfg = config.services.setup-workers;
  in {
    options.services.setup-workers = {
      scripts = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
        description = "List of scripts used to setup the server workers";
      };
    };

    config.packages.setup-workers = pkgs.writeShellApplication {
      name = "setup-workers";
      runtimeInputs = cfg.scripts;
      text = lib.concatMapStringsSep "\n" lib.getExe cfg.scripts;
    };
  };
}