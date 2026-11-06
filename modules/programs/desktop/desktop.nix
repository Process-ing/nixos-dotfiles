{ self, ... }:

{
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      autorandr
      brightnessctl
      dconf
      i3
      lightdm
      xdg
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
      kitty
      nemo
      pavucontrol
      picom
      slack
      specs
      vscode
      x11
      xdg
      zen-browser
    ];
  };
}
