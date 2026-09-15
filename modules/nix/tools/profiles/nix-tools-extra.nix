{ self, ... }:

{
  flake.modules.nixos.nix-tools-extra = {
    imports = with self.modules.nixos; [
      nix-index-database
      impermanence
    ];
  };

  flake.modules.homeManager.nix-tools-extra = {
    imports = with self.modules.homeManager; [
      impermanence
    ];
  };
}
