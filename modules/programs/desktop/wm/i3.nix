{
  flake.modules.nixos.i3 = {
    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;  
    };

    # Set i3 as the default window manager
    services.displayManager.defaultSession = "none+i3";
  };

  flake.modules.homeManager.i3 = { config, lib, ... }: {
    xsession.windowManager.i3 = {
      enable = true;

      config = {
        startup = [
          { command = "autorandr -c"; always = true; }
        ];

        modifier = "Mod4";

        keybindings = let
          mod = config.xsession.windowManager.i3.config.modifier;
        in lib.mkOptionDefault {
          "${mod}+Return" = "exec kitty";
        };

        gaps.inner = 15;
      };
    };
  };
}