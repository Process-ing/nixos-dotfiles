{
  flake.modules.nixos.system-user-registry = { config, lib, ... }: let
    cfg = config.system-user-registry;

    mkSystemUser = userIdx: service: {
      # Define system user settings
      users.${service} = {
        isSystemUser = true;
        group = "${service}";

        home = "/var/lib/${service}";
        createHome = true;

        # Configure subordinate IDs, needed for rootless Podman
        subUidRanges = [{ startUid = 100000 + 65536 * userIdx; count = 65536; }];
        subGidRanges = [{ startGid = 100000 + 65536 * userIdx; count = 65536; }];

        linger = true;  # Allow user services to start/stop with system
      };

      # Create group for system user
      groups.${service} = {};
    };
  in {
    options.system-user-registry = {
      services = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        description = "Services for which to create a user. Each registered service will have a user with the same name as itself.";
      };
    };

    config.users = lib.mkMerge (lib.lists.imap0 mkSystemUser cfg.services);
  };
}