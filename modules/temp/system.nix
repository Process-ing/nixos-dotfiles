{
  flake.modules.nixos.temp-system = {
    # Enable bluetooth
    hardware.bluetooth.enable = true;

    # Prevent rfkill blocking bluetooth
    system.activationScripts = {
      rfkillUnblockBluetooth = {
        deps = [];
        text = ''
          rfkill unblock bluetooth
        '';
      };
    };
  };
}