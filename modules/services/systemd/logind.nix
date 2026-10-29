{
  flake.modules.nixos.logind = {
    services.logind.settings.Login = {
      HandlePowerKey = "ignore";
      HandleLidSwitch = "ignore";
    };
  };
}
