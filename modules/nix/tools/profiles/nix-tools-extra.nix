{ self, ... }:

{
  flake.modules.nixos.nix-tools-extra = {
    imports = with self.modules.nixos; [
      nix-index-database
    ];
  };

  flake.modules.homeManager.nix-tools-extra = {
    imports = [ ];
  };
}
