{ self, ... }:

{
  flake.modules.nixos.services-desktop = {
    imports = with self.modules.nixos; [
      services-console

      wifi
      network-powersaving
      distrobox
    ];
  };
}
