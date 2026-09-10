{ self, ... }:

{
  flake.modules.nixos.nix-tools = {
    imports = with self.modules.nixos; [
      nix-tools-minimal
      nix-index-database
    ];
  };

  flake.modules.homeManager.nix-tools = {
    imports = with self.modules.homeManager; [
      nix-tools-minimal
    ];
  };
}
