{ self, ... }:

{
  flake.modules.homeManager.zygarde = self.lib.mkHomePersist {
    directories = [
      "nixos-dotfiles"
    ];
  };
}
