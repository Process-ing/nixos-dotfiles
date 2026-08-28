{ self, ... }:

{
  flake.modules.nixos.nix-tools-minimal = {
    imports = with self.modules.nixos; [
      home-manager
      sops
      disko
    ];
  };

  flake.modules.homeManager.nix-tools-minimal = {
    imports = with self.modules.homeManager; [
      home-manager
    ];
  };
}