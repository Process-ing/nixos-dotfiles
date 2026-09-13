{ self, ... }:

{
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      i3
    ];
  };

  flake.modules.homeManager.desktop = {
    imports = with self.modules.homeManager; [
      catppuccin
      firefox
      i3
      intellij
      kitty
      vscode
    ];
  };
}
