{ self, ... }:

{
  flake.modules.nixos.brunol-laptop = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      temp-de
      temp-display-conf
      temp-system

      # System profile
      system-server

      # Hardware configuration
      ../../../gen-modules/hosts/brunol-laptop/hardware-configuration.nix

      # Users
      brunol
      zygarde
    ];
  };
}
