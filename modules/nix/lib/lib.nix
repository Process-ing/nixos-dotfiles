{ lib, ... }:

{
  options.flake.lib = lib.mkOption {
    description = "Set of helper functions used throughout the dotfiles";
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };
}
