{ self, ... }:

{
  flake.modules.nixos.network = self.lib.mkPersist {
    directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };
}
