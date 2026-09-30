{ self, ... }:

{
  flake.modules.nixos.services-server = {
    imports = with self.modules.nixos; [
      borg-server
      nginx
      network-server
      podman-server
      ssh-server

      server-workers
    ];
  };
}
