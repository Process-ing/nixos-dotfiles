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

  flake.modules.homeManager.home-manager = {
    
    # In a nutshell, do not touch this
    home.stateVersion = "26.05";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}