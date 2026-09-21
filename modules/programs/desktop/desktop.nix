{ self, ... }:

{
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      autorandr
      i3
    ];
  };

  flake.modules.homeManager.desktop = {
    imports = with self.modules.homeManager; [
      arandr
      brightnessctl
      catppuccin
      distrobox-path
      i3
      kitty
      pavucontrol
      vscode
      zen-browser
    ];
  };
}
