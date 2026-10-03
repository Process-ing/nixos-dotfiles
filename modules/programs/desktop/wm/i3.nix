{
  flake.modules.nixos.i3 = {
    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };
    
    # Enable i3lock
    programs.i3lock.enable = true;
  };

  flake.modules.homeManager.i3 = { lib, pkgs, ... }: let
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

          # Brightness buttons
          "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl -d=intel_backlight set +5%";
          "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl -d=intel_backlight set -5%";

          # Power button
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

        # Window style
        window.titlebar = false;
        window.border = 0;
        floating.border = 0;
        gaps.inner = 15;

        # Floating windows
        window.commands = [
          { command = "floating enable"; criteria.title = "^Volume Control$"; } # pavucontrol
          { command = "floating enable"; criteria.title = "^Network Connections$"; } # nm-connection-editor
        ];
      };
    };
  };
}
