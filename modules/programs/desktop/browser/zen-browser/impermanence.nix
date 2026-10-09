{ self, ... }:

{
  flake.modules.homeManager.zen-browser = self.lib.mkHomePersist {
    directories = [
      ".config/zen"
    ];
  };
}
