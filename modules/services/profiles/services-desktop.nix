{ self, ... }:

{
  flake.modules.nixos.services-desktop = {
    imports = with self.modules.nixos; [
      bluetooth
      borg-laptop
      distrobox
      l2tp
      logind
      network-powersaving
      pipewire
      wifi
    ];
  };

  flake.modules.homeManager.services-desktop = {
    imports = with self.modules.homeManager; [
      gnome-keyring
      pipewire
    ];
  };
}
