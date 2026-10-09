{ self, ... }:

{
  flake.modules.homeManager.direnv = self.lib.mkHomePersist {
    directories = [
      ".config/direnv"
    ];
  };
}
