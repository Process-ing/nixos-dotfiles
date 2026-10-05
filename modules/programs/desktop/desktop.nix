{ self, ... }:

{
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      autorandr
      brightnessctl
      dconf
      i3
    ];
  };

  flake.modules.homeManager.desktop = {
    imports = with self.modules.homeManager; [
      autorandr
      arandr
      catppuccin
      dconf
      distrobox-path
      gtk
      i3
      jetbrains-impermanence
      kitty
      nemo
      pavucontrol
      picom
      slack
      vscode
      x11
      zen-browser
    ];
  };
}
