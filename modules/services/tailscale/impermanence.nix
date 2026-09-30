{ self, ... }:

{
  flake.modules.nixos.tailscale = self.lib.mkPersist {
    directories = [
      "/var/lib/tailscale"
    ];
  };
}