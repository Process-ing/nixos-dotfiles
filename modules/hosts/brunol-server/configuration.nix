{ self, ... }:

{
  flake.modules.nixos.brunol-server = { pkgs, ... }: {
    imports = with self.modules.nixos; [

      # System profile
      system-server

      # Hardware configuration
      ../../../generated/hosts/brunol-server/hardware-configuration.nix

      # Users
      zygarde
    ];
  };
}
