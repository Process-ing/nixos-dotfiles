{ self, ... }:

{
  flake.modules.homeManager.direnv = self.lib.mkHomePersist {
    directories = [
      ".local/share/direnv"
    ];
  };
}
