{
  flake.modules.nixos.logind = {
    services.logind.settings.Login = {
      HandlePowerKey = "suspend";
      HandleLidSwitch = "ignore";
    };

    # tiny_power_button will still power down the PC on power key press (thanks
    # NixOS, literally no one asked)
    boot.blacklistedKernelModules = [ "tiny_power_button" ];
  };
}
