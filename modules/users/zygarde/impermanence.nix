{ self, ... }:

{
  flake.modules.homeManager.zygarde = self.lib.mkPersist {
    directories = [
      "nixos-dotfiles"
    ];
  };
}