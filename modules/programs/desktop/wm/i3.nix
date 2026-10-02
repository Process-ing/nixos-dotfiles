{
  flake.modules.nixos.i3 = {
    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };

    # Set i3 as the default window manager
    services.displayManager.defaultSession = "none+i3";
  };

  flake.modules.homeManager.i3 = { lib, ... }: let
    mod = "Mod4";
  in {
    xsession.windowManager.i3 = {
      enable = true;

      config = {
        startup = [
          {
            command = "autorandr -c";
            always = true;
          }
        ];

        modifier = mod;

        keybindings = lib.mkOptionDefault {
          "${mod}+Return" = "exec kitty";
          "XF86PowerOff" = "exec i3lock && systemctl suspend";
        };

        workspaceOutputAssign = [
          {
            output = "eDP-1";
            workspace = "1";
          }
          {
            output = "DP-1-1";
            workspace = "2";
          }
        ];

        gaps.inner = 15;
      };
    };
  };
}
