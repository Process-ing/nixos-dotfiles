{
  flake.modules.homeManager.fastfetch = let
    percent = {
      type = 3;
      green = 50;
      yellow = 80;
    };
  in {
    programs.fastfetch = {
      enable = true;

      settings = {
        display = {
          separator = " ";
          brightColor = true;

          color = {
            keys = "";
            title = "white";
            output = "white";
          };
        };

        modules = [
          {
            type = "title";
            key = "  Login";
            keyColor = "blue";
          }
          {
            type = "break";
          }
          {
            type = "os";
            key = "  OS";
            keyColor = "cyan";
          }
          {
            type = "kernel";
            key = "├─   Kernel";
            keyColor = "cyan";
          }
          {
            type = "locale";
            key = "├─   Locale";
            keyColor = "cyan";
          }
          {
            type = "packages";
            key = "└─   Packages";
            keyColor = "cyan";
          }
          {
            type = "uptime";
            key = "└─ Uptime";
            keyColor = "cyan";
          }
          {
            type = "break";
          }
          {
            type = "chassis";
            key = "  PC";
            keyColor = "blue";
          }
          # {
          #   type = "board";
          #   key = "├─   Board";
          #   keyColor = "blue";
          # }
          # {
          #   type = "bios";
          #   key = "├─ BIOS";
          #   keyColor = "blue";
          # }
          {
            type = "cpu";
            key = "├─ CPU";
            keyColor = "blue";
            temp = true;
          }
          {
            type = "gpu";
            key = "├─ GPU {1}";
            keyColor = "blue";
            temp = true;
          }
          {
            type = "display";
            key = "├─ Display";
            keyColor = "blue";
          }
          {
            type = "sound";
            key = "├─ Sound";
            keyColor = "blue";
          }
          {
            type = "battery";
            key = "├─ Battery";
            keyColor = "blue";
          }
          {
            type = "disk";
            key = "├─ Disk";
            keyColor = "blue";
            format = "{size-percentage-bar} {size-used} / {size-total} [{filesystem}] ({mountpoint})";
            inherit percent;
          }
          {
            type = "memory";
            key = "├─ RAM";
            keyColor = "blue";
            format = "{percentage-bar} {used} / {total}";
            inherit percent;
          }
          {
            type = "swap";
            key = "└─ Swap";
            keyColor = "blue";
            format = "{percentage-bar} {used} / {total}";
            inherit percent;
          }
          {
            type = "break";
          }
          {
            type = "custom";
            format = "{#cyan}Network{#}";
          }
          {
            type = "wifi";
            key = "├─ Wifi";
            keyColor = "cyan";
          }
          {
            type = "bluetooth";
            key = "├─ Bluetooth Dev";
            keyColor = "cyan";
          }
          {
            type = "localip";
            key = "├─ IP";
            keyColor = "cyan";
          }
          {
            type = "publicip";
            key = "└─ Public IP";
            keyColor = "cyan";
          }
          {
            type = "break";
          }
          {
            type = "de";
            key = "Desktop";
            keyColor = "blue";
          }
          {
            type = "wm";
            key = "├─ Window Manager";
            keyColor = "blue";
          }
          {
            type = "lm";
            key = "├─ Login Manager";
            keyColor = "blue";
          }
          {
            type = "wmtheme";
            key = "├─ WM Theme";
            keyColor = "blue";
          }
          {
            type = "theme";
            key = "├─ Color Theme";
            keyColor = "blue";
          }
          {
            type = "icons";
            key = "├─ System Icons";
            keyColor = "blue";
          }
          {
            type = "font";
            key = "├─ System Font";
            keyColor = "blue";
          }
          {
            type = "terminal";
            key = "└─ Terminal";
            keyColor = "blue";
          }
        ];
      };
    };
  };
}