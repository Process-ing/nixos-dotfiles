{ inputs, ... }:

{
  flake.modules.nixos.sops =
    { config, ... }:
    {
      imports = [
        inputs.sops-nix.nixosModules.sops
      ];

      sops = {
        # Specify secrets path
        defaultSopsFile = ../../../../secrets/${config.networking.hostName}.yaml;

        # Specify SOPS key path
        age.keyFile = "/persistent/var/lib/sops-nix/key.txt";
      };

      # Add SOPS to environment variables (needed by `sops` command)
      environment.sessionVariables = {
        SOPS_AGE_KEY_FILE = "/var/lib/sops-nix/key.txt";
      };
    };
}
