{ self, ... }:

{
  flake.modules.nixos.nix-tools = {
    imports = with self.modules.nixos; [
      home-manager
      sops
    ];
  };
}