{
  flake.modules.homeManager.vscode = { pkgs, ... }: {
    programs.vscode = {
      enable = true;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
        ];

        userSettings = {
          "window.zoomLevel" = 2;
          "telemetry.telemetryLevel" = "off";
        };
      };
    };

    # Configure theme (Catppuccin)
    catppuccin.vscode = {
      accent = "blue";
      settings = { };
    };
  };
}
