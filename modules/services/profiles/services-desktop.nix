{ self, ... }:

{
  flake.modules.nixos.services-desktop = {
    imports = with self.modules.nixos; [
      bluetooth
      distrobox
      logind
      network-powersaving
      openvpn
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
