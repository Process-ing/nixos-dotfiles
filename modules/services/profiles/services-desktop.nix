{ self, ... }:

{
  flake.modules.nixos.services-desktop = {
    imports = with self.modules.nixos; [
      services-console

      bluetooth
      distrobox
      logind
      network-powersaving
      pipewire
      wifi
    ];
  };
}
