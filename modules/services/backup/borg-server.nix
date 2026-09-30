{
  flake.modules.nixos.borg-server = { config, ... }: {
    users = {
      # Declare borg password secret
      sops.secrets."users/borg/password_hash" = {
        neededForUsers = true;
      };

      # Create borg user
      users.borg = {
        isNormalUser = true;
        passwordHashFile = config.sops.secrets."users/borg/password_hash".path;
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