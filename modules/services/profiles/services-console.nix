{ self, ... }:

{
  flake.modules.nixos.services-console = {
    imports = with self.modules.nixos; [
      borg
      network
      podman
      powersaving
      ssh
      tailscale
    ];
  };

  flake.modules.homeManager.services-console = {
    imports = with self.modules.homeManager; [
      podman
    ];
  };
}
