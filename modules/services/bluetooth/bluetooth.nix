{
  flake.modules.nixos.bluetooth = { pkgs, ... }: {
    # Enable bluetooth
    hardware.bluetooth.enable = true;

    # Prevent rfkill blocking bluetooth
    systemd.user.services.rfkill-unblock-bluetooth = {
      enable = true;
      after = [ "systemd-rfkill.target" ];
      wantedBy = [ "default.target" ];

      serviceConfig.Type = "oneshot";

      path = [ pkgs.libuuid ];

      script = ''
        rfkill unblock bluetooth
      '';
    };
  };
}
