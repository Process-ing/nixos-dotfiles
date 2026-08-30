{ self, ... }:

{
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [];
  };

  flake.modules.homeManager.desktop = {
    imports = with self.modules.homeManager; [
      firefox
      kitty
    ];
  };
}