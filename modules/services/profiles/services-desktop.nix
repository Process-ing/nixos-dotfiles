{ self, ... }:

{
  flake.modules.nixos.services-desktop = {
    imports = with self.modules.nixos; [
      services-console

      distrobox
      logind
      network-powersaving
      wifi
    ];
  };
}
