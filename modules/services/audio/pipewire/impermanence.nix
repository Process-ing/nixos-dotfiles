{ self, ... }:

{
  flake.modules.homeManager.pipewire = self.lib.mkHomePersist {
    files = [
      ".local/state/wireplumber/stream-properties"
    ];
  };
}