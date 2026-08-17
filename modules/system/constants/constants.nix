{
  flake.modules.generic.constants = { lib, ... }: {
    options.constants = lib.mkOption {
      description = "Contains constants to be used throughout these dotfiles";
      type = lib.types.attrsOf lib.types.unspecified;
      default = {};
    };
  };
}