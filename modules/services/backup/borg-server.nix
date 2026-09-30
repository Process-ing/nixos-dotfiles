{
  flake.modules.nixos.borg-server = { config, ... }: {
    users = {
      # Create borg user
      users.borg = {
        isSystemUser = true;
        group = "borg";

        home = "/mnt/raid1/borg";
        createHome = true;

        # Define who can create backups
        openssh.authorizedKeys.keys = [
          config.constants.publicKey.brunol-inputless
        ];
      };

      # Create borg group
      groups.borg = { };
    };
  };
}