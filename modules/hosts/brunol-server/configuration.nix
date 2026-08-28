{ self, ... }:

{
  flake.modules.nixos.brunol-server = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      temp-de
      temp-display-conf
      temp-system

      # System profile
      system-server

      # Hardware configuration
      ../../../generated/hosts/brunol-server/hardware-configuration.nix

      # Users
      brunol
      zygarde
    ];
  };
}
