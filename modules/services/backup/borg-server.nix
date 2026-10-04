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

    # Define repos
    services.borgbackup.repos = {
      "brunol-laptop" = {
        user = "borg";
        group = "borg";
        path = "${config.users.users.borg.home}/brunol-laptop";
        authorizedKeys = [
          config.constants.publicKey.brunol-inputless
        ];
      };
    };
  };
}