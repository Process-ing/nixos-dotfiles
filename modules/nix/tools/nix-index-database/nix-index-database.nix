{ inputs, ... }:

{
  flake.modules.nixos.nix-index-database = {
    imports = [
      inputs.nix-index-database.nixosModules.default
    ];

    # Enable comma
    programs.nix-index-database.comma.enable = true;
  };
}