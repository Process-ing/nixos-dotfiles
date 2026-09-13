{
  flake.modules.homeManager.vscode = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;

      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
        ];

        userSettings = {
          workbench = {
            colorTheme = "Catppuccin Mocha";
            iconTheme = "catppuccin-mocha";
          };

          "window.zoomLevel" = 2;
          "telemetry.telemetryLevel" = "off";
        };
      };
    };
  };
}
