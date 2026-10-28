{ self, ... }:

{
  flake.modules.nixos.services-desktop = {
    imports = with self.modules.nixos; [
      bluetooth
      borg-laptop
      distrobox
      feup-vpn
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
      pipewire
      udisks
    ];
  };
}
