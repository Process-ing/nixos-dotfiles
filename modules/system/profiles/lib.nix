{ inputs, lib, ... }:

{
  config.flake.lib = {
    # Builds a Linux NixOS configuration
    mkNixos = system: name: {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          # Include host module
          inputs.self.modules.nixos.${name}
          {
            # Set platform
            nixpkgs.hostPlatform = lib.mkDefault system;

            # Set hostname
            networking.hostName = lib.mkDefault name;
          }
        ];
      };
    };
  };
}