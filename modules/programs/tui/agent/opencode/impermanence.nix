{ self, ... }:

{
  flake.modules.homeManager.opencode = self.lib.mkHomePersist {
    directories = [
      ".local/share/opencode"
      ".local/state/opencode"
    ];
  };
}