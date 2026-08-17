{ self, ... }:

{
  flake.modules.nixos.tui = {
    imports = with self.modules.nixos; [
      vim
    ];
  };

  flake.modules.homeManager.tui = {
    imports = with self.modules.homeManager; [
      opencode
    ];
  };
}