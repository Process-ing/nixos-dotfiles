{
  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # Prevent rfkill blocking bluetooth
  system.activationScripts = {
    rfkillUnblockBluetooth = {
      deps = [];
      text = ''
        rfkill unblock 0  #hci0
        rfkill unblock 2  #ideapad_bluetooth
      '';
    };
  };
}