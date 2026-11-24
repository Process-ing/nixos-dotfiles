{ self, ... }:

{
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      autorandr
      brightnessctl
      dconf
      i3
      lightdm
      nvidia
      xdg
    ];
  };

  flake.modules.homeManager.desktop = {
    imports = with self.modules.homeManager; [
      autorandr
      arandr
      catppuccin
      chromium
      dconf
      distrobox-path
      gtk
      i3
      kitty
      mindustry
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
