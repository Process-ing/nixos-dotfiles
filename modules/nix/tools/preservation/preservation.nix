{ inputs, ... }:

{
  flake.modules.nixos.preservation = {
    imports = [ inputs.preservation.nixosModules.preservation ];

    # Create basic configuration
    preservation.preserveAt."/persistent" = {
      files = [
        { file = "/etc/machine-id"; isInitrd = true; } # Auto-generated machine ID
      ];
      
      directories = [
        "/var/lib/systemd/timers"
        "/var/lib/nixos" # NixOS user state
        "/var/log"
      ];
    };

    # Disable system-machine-id-commit.service (it would crash and is not needed anyways)
    systemd.surpressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  };
}