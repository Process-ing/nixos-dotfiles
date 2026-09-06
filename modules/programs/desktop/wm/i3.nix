{
  flake.modules.nixos.i3 = {
    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;  
    };

    # Set i3 as the default window manager
    services.displayManager.defaultSession = "none+i3";
  };

  flake.modules.homeManager.i3 = {
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        startup = [
          { command = "autorandr -c"; always = true; }
        ];
      };
    };
  };
}