{ inputs, lib, ... }:

{
  config.flake.lib = {

    # Builds the Home Manager configuration for a user
    mkHomeManager = system: name: {
      ${name} = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};

        modules = [
          inputs.self.modules.homeManager.${name}
        ];
      };
    };
  };
}