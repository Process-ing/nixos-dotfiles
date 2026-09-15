{ self, ... }:

{
  flake.modules.nixos.services-console = {
    imports = with self.modules.nixos; [
      ssh
      podman
      network
      powersaving
    ];
  };

  flake.modules.homeManager.services-console = {
    imports = with self.modules.homeManager; [
      podman
    ];
  };
}
