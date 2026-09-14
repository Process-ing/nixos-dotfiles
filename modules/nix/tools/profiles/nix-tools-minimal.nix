{ self, ... }:

{
  flake.modules.nixos.nix-tools-minimal = {
    imports = with self.modules.nixos; [
      disko
      home-manager
      preservation
      sops
    ];
  };

  flake.modules.homeManager.nix-tools-minimal = {
    imports = with self.modules.homeManager; [
      home-manager
    ];
  };
}
