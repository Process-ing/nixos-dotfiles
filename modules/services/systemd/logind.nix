{
  flake.modules.nixos.logind = {
    services.logind.settings.Login = {
      HandlePowerKey = "suspend";
      HandleLidSwitch = "ignore";
    };
  };
}