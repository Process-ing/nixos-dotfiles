{ self, ... }:

{
  flake.modules.nixos.brunol-laptop = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      temp-de
      temp-display-conf
      temp-system

      # System profile
      system-desktop

      # Hardware configuration
      ./_hardware-configuration.nix

      # Users
      brunol

      # Fix timezone
      locale-laptop
    ];

    # Disable preservation
    preservation.enable = false;
  };
}
