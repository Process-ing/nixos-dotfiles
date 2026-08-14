{
  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Prevent rfkill blocking bluetooth
  system.activationScripts = {
    rfkillUnblockBluetooth = {
      deps = [];
      text = ''
        rfkill unblock hci0
        rfkill unblock ideapad_bluetooth
      '';
    };
  };
}