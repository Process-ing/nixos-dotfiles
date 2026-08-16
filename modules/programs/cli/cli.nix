{ self, ... }:

{
  flake.modules.nixos.cli = {
    imports = with self.modules.nixos; [];
  };

  flake.modules.homeManager.cli = {
    imports = with self.modules.homeManager; [
      git
      fastfetch
    ];
  };
}