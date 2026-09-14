{ self, ... }:

{
  flake.modules.nixos.brunol-server = { pkgs, ... }: {
    imports = with self.modules.nixos; [

      # System profile
      system-server

      # Hardware configuration
      ./_hardware-configuration.nix

      # Users
      zygarde
    ];

    # Disable preservation
    preservation.enable = false;
  };
}
