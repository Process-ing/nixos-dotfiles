{ inputs, self, ... }:

{
  # Minimal configuration for NixOS
  flake.modules.nixos.system-minimal = {
    imports = with self.modules.nixos; [
      settings-minimal
      nix-store
      nix-tools-minimal
      self.modules.generic.constants  # Allow constants usage
    ];

    
    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # In a nutshell, do not touch this
    system.stateVersion = "26.05";
  };

  # Minimal configuration for Home Manager
  flake.modules.homeManager.system-minimal = {
    imports = with self.modules.homeManager; [
      nix-tools-minimal
      self.modules.generic.constants         # Allow constants usage
    ];
  };
}