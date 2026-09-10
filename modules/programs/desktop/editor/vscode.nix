{
  flake.modules.nixos.vscode = { lib, ... }: {
    # Add VSCode to unfree package whitelist
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "code"
      "vscode"
    ];
  };

  flake.modules.homeManager.vscode = { pkgs, ... }: {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;

      profiles = {
        default = {
          extensions = with pkgs.vscode-extensions; [
            catppuccin.catppuccin-vsc
            catppuccin.catppuccin-vsc-icons
          ];
        };
      };
    };
  };
}