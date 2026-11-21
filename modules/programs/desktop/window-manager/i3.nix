{
  flake.modules.nixos.i3 = { pkgs, ... }: {
    services.xserver = {
      enable = true;
      windowManager.i3.enable = true;
    };

    # Set i3 as the default window manager
    services.displayManager.defaultSession = "none+i3";

    # Set i3lock as the default screen locker with xss-lock
    programs.xss-lock = {
      enable = true;
      lockerCommand = "${pkgs.i3lock}/bin/i3lock";
    };
  };

  flake.modules.homeManager.i3 =
    { lib, pkgs, ... }:
    let
      mod = "Mod4";
    in
    {
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
            "XF86MonBrightnessUp" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl --device=intel_backlight set +5%";
            "XF86MonBrightnessDown" = "exec --no-startup-id ${pkgs.brightnessctl}/bin/brightnessctl --device=intel_backlight set 5%-";

            # Audio buttons
            "XF86AudioRaiseVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ +5%";
            "XF86AudioLowerVolume" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%";
            "XF86AudioMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-sink-mute @DEFAULT_SINK@ toggle";
            "XF86AudioMicMute" = "exec --no-startup-id ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";

            # Media control
            "XF86AudioPlay" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl play-pause";
            "XF86AudioStop" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl stop";
            "XF86AudioNext" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl next";
            "XF86AudioPrev" = "exec --no-startup-id ${pkgs.playerctl}/bin/playerctl previous";

            # Power button
            # "XF86PowerOff" = "exec systemctl suspend";
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
            {
              output = "HDMI-1-1";
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
            {
              command = "floating enable";
              criteria.title = "^Volume Control$";
            } # pavucontrol
            {
              command = "floating enable";
              criteria.title = "^Network Connections$";
            } # nm-connection-editor
          ];
        };
      };
    };
}
