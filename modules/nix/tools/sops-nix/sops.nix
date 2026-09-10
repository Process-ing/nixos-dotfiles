{ inputs, ... }:

{
  flake.modules.nixos.sops =
    { config, ... }:
    let
      keyFilePath = "/var/lib/sops-nix/key.txt";
    in
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      sops = {
        # Specify secrets path
        defaultSopsFile = ../../../../secrets/${config.networking.hostName}.yaml;

        # Specify SOPS key path
        age.keyFile = keyFilePath;
      };

      # Add SOPS to environment variables (needed by `sops` command)
      environment.sessionVariables = {
        SOPS_AGE_KEY_FILE = keyFilePath;
      };
    };
}
