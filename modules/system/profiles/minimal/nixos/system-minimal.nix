{ inputs, ... }:

{
  # Generic configuration for NixOS
  flake.modules.nixos.system-minimal = {
    imports = with inputs.self.modules.nixos; [
      keyboard
      locale
      grub
    ];

    
    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # In a nutshell, do not touch this
    system.stateVersion = "26.05";
  };
}