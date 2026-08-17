{ inputs, self, ... }:

{
  # Generic configuration for NixOS
  flake.modules.nixos.system-minimal = {
    imports = with self.modules.nixos; [
      settings-minimal
    ] ++ [
      self.modules.generic.constants  # Allow constants usage
    ];

    
    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # In a nutshell, do not touch this
    system.stateVersion = "26.05";
  };
}