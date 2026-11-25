{ self, ... }: 

{
  flake.modules.homeManager.discord = self.lib.mkHomePersist {
    directories = [ ".config/discord" ];
  };
}