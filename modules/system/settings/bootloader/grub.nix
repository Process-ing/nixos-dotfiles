{
  flake.modules.nixos.grub = {

    # Configure GRUB as the bootloader
    boot.loader = {
      grub = {
        enable = true;
        device = "nodev";  # This only works in UEFI, change later (aka TODO)
        efiSupport = true;
        useOSProber = true;
      };

      efi.canTouchEfiVariables = true;
    };
  };
}