{ self, ... }:

{
  flake.modules.homeManager.zsh = self.lib.mkHomePersist {
    files = [
      ".zsh_history"
    ];
  };

  flake.modules.homeManager.powerlevel10k = self.lib.mkHomePersist {
    directories = [
      ".cache/gitstatus"
    ];
  };
}