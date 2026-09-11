{ self, ... }:

{
  flake.modules.nixos.desktop = {
    imports = with self.modules.nixos; [
      i3
      vscode
    ];
  };

  flake.modules.homeManager.desktop = {
    imports = with self.modules.homeManager; [
      i3
      firefox
      intellij
      kitty
      vscode
    ];
  };
}
