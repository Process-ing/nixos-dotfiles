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
      distrobox-path
      i3
      jetbrains-impermanence
      kitty
      pavucontrol
      vscode
      x11
      zen-browser
    ];
  };
}
