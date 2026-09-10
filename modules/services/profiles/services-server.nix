{ self, ... }:

{
  flake.modules.nixos.services-server = {
    imports = with self.modules.nixos; [
      services-console

      nginx
      network-server
      podman-server
      ssh-server

      server-workers
    ];
  };
}
