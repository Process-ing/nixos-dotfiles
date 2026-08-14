{ inputs, lib, ... }

{
  # Builds the Home Manager configuration for a user
  mkHomeManager = system: user: {
    ${user} = home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};

      modules = [
        inputs.self.modules.homeManager.${name}
      ]
    };
  };
}