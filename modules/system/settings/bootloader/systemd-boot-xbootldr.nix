{
  # Extra configurations to make systemd-boot work with XBOOTLDR partition
  flake.modules.nixos.systemd-boot-xbootldr = {
    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/efi";
      };

      systemd-boot.xbootldrMountPoint = "/boot";
    };
  };
}
