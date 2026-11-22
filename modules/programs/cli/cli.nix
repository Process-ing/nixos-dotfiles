{ self, ... }:

{
  flake.modules.nixos.cli = {
    imports = with self.modules.nixos; [
      zsh
    ];
  };

  flake.modules.homeManager.cli = {
    imports = with self.modules.homeManager; [
      devenv
      direnv
      fastfetch
      git
      trash-cli
      zsh
    ];
  };
}
