{ self, ... }:

{
  flake.modules.homeManager.chromium = self.lib.mkHomePersist {
    directories = [ ".config/chromium" ];
  };
}