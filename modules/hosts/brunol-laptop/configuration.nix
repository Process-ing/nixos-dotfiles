{ self, ... }:

{
  flake.modules.nixos.brunol-laptop = { pkgs, ... }: {
    imports = with self.modules.nixos; [
      # System profile
      system-desktop

      # Hardware configuration
      ./_hardware-configuration.nix
      impermanence-rollback # Rollback root for impermanent setup

      # Users
      brunol

      # Fix timezone
      locale-laptop

      # Use XBOOTLDR partition
      systemd-boot-xbootldr
    ];

    # Ensure /persistent is available at boot time
    fileSystems."/persistent".neededForBoot = true;

    # Enable impermanence
    impermanence.enable = true;
  };
}
