{ self, ... }:

{
  flake.modules.nixos.services-desktop = {
    imports = with self.modules.nixos; [
      bluetooth
      distrobox
      logind
      network-powersaving
      pipewire
      wifi
    ];
  };
}
