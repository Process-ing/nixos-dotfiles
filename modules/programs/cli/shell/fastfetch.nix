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
            type = "break";
          }
          {
            type = "chassis";
            key = "  PC";
            keyColor = "blue";
          }
          {
            type = "board";
            key = "├─   Board";
            keyColor = "blue";
          }
          {
            type = "bios";
            key = "├─ BIOS";
            keyColor = "blue";
          }
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
        ];
      };
    };
  };
}