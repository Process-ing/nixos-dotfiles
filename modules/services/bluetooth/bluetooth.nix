{
  flake.modules.nixos.bluetooth = {
    # Enable bluetooth
    hardware.bluetooth.enable = true;

    # Prevent rfkill blocking bluetooth
    systemd.user.services.rfkill-unblock-bluetooth = {
      enable = true;
      after = [ "systemd-rfkill.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "rfkill unblock bluetooth";
      };
    };
  };
}