{ self, ... }:

{
  flake.modules.nixos.services-desktop = with self.modules.nixos; [
    services-console

    wifi
    network-powersaving
  ];
}