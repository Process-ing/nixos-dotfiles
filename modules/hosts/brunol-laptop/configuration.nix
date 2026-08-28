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
      ../../../generated/hosts/brunol-laptop/hardware-configuration.nix

      # Users
      brunol
    ];
  };
}
