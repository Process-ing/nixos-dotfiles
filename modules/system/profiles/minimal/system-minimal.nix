{ inputs, self, ... }:

{
  # Minimal configuration for NixOS
  flake.modules.nixos.system-minimal = {
    imports = [
      self.modules.nixos.settings-minimal
      self.modules.generic.constants  # Allow constants usage
    ];

    
    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # In a nutshell, do not touch this
    system.stateVersion = "26.05";
  };

  # Minimal configuration for Home Manager
  flake.modules.homeManager.system-minimal = {
    imports = [
      self.modules.homeManager.home-manager
      self.modules.generic.constants  # Allow constants usage
    ];
  };
}