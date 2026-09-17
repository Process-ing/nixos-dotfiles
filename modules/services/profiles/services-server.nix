{ self, ... }:

{
  flake.modules.nixos.services-server = {
    imports = with self.modules.nixos; [
      nginx
      network-server
      podman-server
      ssh-server

      server-workers
    ];
  };
}
