{ inputs, ... }:

{
  flake.modules.nixos.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
    ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      # Allow backing up existing files
      backupFileExtension = "bak";
    };
  };
}