{ self, ... }:

{
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      autorandr
      brightnessctl
      i3
    ];
  };

  flake.modules.homeManager.desktop = {
    imports = with self.modules.homeManager; [
      arandr
      catppuccin
      chromium
      distrobox-path
      i3
      jetbrains-impermanence
      kitty
      pavucontrol
      slack
      vscode
      x11
      zen-browser
    ];
  };
}
