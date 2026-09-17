{ self, ... }:

{
  flake.modules.nixos.podman = self.lib.mkPersist {
    directories = [
      "/var/lib/containers/storage"
    ];
  };

  flake.modules.homeManager.podman = self.lib.mkHomePersist {
    directories = [
      ".local/share/containers/storage"
    ];
  };
}