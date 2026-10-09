{ self, ... }:

{
  flake.modules.nixos.bluetooth = self.lib.mkPersist {
    directories = [
      "/var/lib/bluetooth"
    ];
  };
}
