{ self, ... }:

{
  flake.modules.homeManager.slack = self.lib.mkHomePersist {
    directories = [
      ".config/Slack"
    ];
  };
}
