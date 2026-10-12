{ self, ... }:

{
  flake.modules.nixos.services-desktop = {
    imports = with self.modules.nixos; [
      bluetooth
      borg-laptop
      distrobox
      feup-vpn
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
      gnome-keyring
      pipewire
      udisks
    ];
  };
}
