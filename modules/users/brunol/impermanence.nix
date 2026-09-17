{ self, ... }:

{
  flake.modules.homeManager.brunol = self.lib.mkHomePersist {
    directories = [
      "erasmus"
      "nixos-dotfiles"
      "specs"
      "staging"
    ];
  };
}