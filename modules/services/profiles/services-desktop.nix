{ self, ... }:

{
  flake.modules.nixos.services-desktop = {
    imports = with self.modules.nixos; [
      bluetooth
      borg-laptop
      distrobox
      gnome-keyring
      logind
      network-powersaving
      pipewire
      udisks
      wifi
    ];
  };

  flake.modules.homeManager.services-desktop = {
    imports = with self.modules.homeManager; [
      dunst
      feup-vpn
      gnome-keyring
      pipewire
      udisks
    ];
  };
}
