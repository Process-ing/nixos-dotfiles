{
  flake.modules.nixos.borg-laptop = { config, ... }: {
    services.borgbackup.jobs.persistent = {
      paths = "/home/brunol";

      environment.BORG_RSH = "ssh -i /home/brunol/.secrets/id_ed25519_inputless";
      repo = "borg@brunol-server:.";
      doInit = true;

      encryption.mode = "none";
      compression = "auto,zstd";
      startAt = "daily";
    };
  };
}