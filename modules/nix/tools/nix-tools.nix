{ self, ... }:

{
  flake.modules.nixos.nix-tools = {
    imports = with self.modules.nixos; [
      home-manager
      sops
      nix-index-database
    ];
  };

  flake.modules.homeManager.nix-tools = {
    imports = with self.modules.homeManager; [
      home-manager
    ];
  };
}