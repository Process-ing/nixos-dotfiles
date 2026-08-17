{
  flake.modules.generic.constants = { lib, ... }: {
    # Contains constants to be used throughout these dotfiles
    options.constants = lib.mkOption {
      type = lib.types.attrsOf lib.types.unspecified;
      default = {};
    };
  };
}