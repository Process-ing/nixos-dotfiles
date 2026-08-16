{ inputs, ... }:

{
  flake.modules.nixos.sops = { config, ... }: {
    imports = [
      inputs.sops-nix.nixosModules.sops
    ];

    sops = {

      # Specify secrets path
      defaultSopsFile = ../../../../secrets/${config.networking.hostName}.yaml;

      # Specify SOPS key path
      age.keyFile = "/var/lib/sops-nix/key.txt";
    };
  };
}