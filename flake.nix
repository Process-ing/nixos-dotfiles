{
  description = "My personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.brunol-server = nixpkgs.lib.nixosSystem {
      modules = [ ./configuration.nix ];
    };
  };
}

