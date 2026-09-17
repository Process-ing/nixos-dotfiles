{ self, ... }:

{
  flake.modules.homeManager.zsh = self.lib.mkHomePersist {
    files = [
      ".zsh_history"
    ];
  };
}