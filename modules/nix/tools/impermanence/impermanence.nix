{ inputs, ... }:

{
  flake.modules.nixos.impermanence =
    { config, lib, ... }:
    let
      cfg = config.impermanence;
    in
    {
      imports = [ inputs.impermanence.nixosModules.impermanence ];

      options.impermanence.enable = lib.mkEnableOption "impermanent setup";

      config = {
        environment.persistence."/persistent" = {
          enable = cfg.enable; # Only activated if enabled explicitly
          hideMounts = true; # Make bind mounts not show as drives

          # Minimal impermanent setup files
          directories = [
            "/var/log"
            "/var/lib/nixos"
            "/var/lib/systemd/coredump"
          ];

          files = [
            "/etc/machine-id"
          ];
        };
      };
    };

  flake.modules.homeManager.impermanence = { osConfig, ... }: {
    home.persistence."/persistent".enable = osConfig.impermanence.enable;
  };
}
