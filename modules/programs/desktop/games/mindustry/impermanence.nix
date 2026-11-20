{ self, ... }:

{
  flake.modules.homeManager.mindustry = self.lib.mkHomePersist {
    directories = [ ".local/share/Mindustry" ];
  };
}