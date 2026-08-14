{
  # Generic configuration for NixOS
  flake.modules.nixos.system-base = {
    
    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # In a nutshell, do not touch this
    system.stateVersion = "26.05";
  };
}