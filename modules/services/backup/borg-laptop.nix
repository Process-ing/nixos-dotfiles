{
  flake.modules.nixos.borg-laptop = { config, ... }: {
    services.borgbackup.jobs.persistent = {
      paths = "/home/brunol";
      encryption.mode = "none";
      environment.BORG_RSH = "ssh -i /home/brunol/.secrets/id_ed25519_inputless";
      repo = "ssh://borg@brunol-server:~/laptop";
      compression = "auto,zstd";
      startAt = "daily";
    };
  };
}