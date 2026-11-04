{ self, ... }:

{
  flake.modules.homeManager.specs = self.lib.mkHomePersist {
    directories = [ ".gradle" ];
  };
}