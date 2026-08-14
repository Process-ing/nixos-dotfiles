{
  description = "My personal NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.brunol-server = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
      ];
    };
  };

  # outputs = inputs @ { flake-parts, ... }: flake-parts.lib.mkFlake { inherit imputs; } {
      

  #     systems = [ "x86_64-linux" ];
  #   }
}

