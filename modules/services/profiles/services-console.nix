{ self, ... }:

{
  flake.modules.nixos.services-console = {
    imports = with self.modules.nixos; [
      ssh
      podman
      network
    ];
  };
}