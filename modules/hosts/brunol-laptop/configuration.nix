{ self, ... }:

{
  flake.modules.nixos.brunol-laptop = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      # System profile
      system-desktop

      # Hardware configuration
      ./_hardware-configuration.nix
      # impermanence-rollback # Rollback root for impermanent setup

      # Users
      brunol

      # Fix timezone
      locale-laptop
    ];
  };
}
