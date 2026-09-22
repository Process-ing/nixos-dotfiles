{
  flake.modules.homeManager.vscode = { pkgs, ... }: {
    programs.vscode = {
      enable = true;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
        ];

        userSettings = {
          # Basic
          "files.autoSave" = "afterDelay";
          "telemetry.telemetryLevel" = "off";

          # Appearance
          "editor.fontFamily" = "'FiraCode Nerd Font', 'Droid Sans Mono', monospace";
          "editor.fontLigatures" = true;
          "window.zoomLevel" = 2;
        };
      };
    };

    # Configure theme (Catppuccin)
    catppuccin.vscode.profiles.default = {
      accent = "blue";
      settings = { };
    };

    # Modify the VSCode arguments
    home.file.".vscode/argv.json".text = ''
      {
        "enable-crash-reporter": false,
        "crash-reporter-id": "4e8461dc-be84-421a-9c2d-b58ba032109c",

        // Make VSCode use properly the OS keyring
        "password-store": "gnome-libsecret"
      }
    '';
  };
}
