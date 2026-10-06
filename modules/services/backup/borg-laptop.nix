{
  flake.modules.nixos.borg-laptop = { config, ... }: {
    # Declare ssh key secret
    sops.secrets."borg-ssh-key" = { };
    
    # Declare borgbackup job
    services.borgbackup.jobs.persistent = {
      paths = "/persistent";

      environment.BORG_RSH = "ssh -i ${config.sops.secrets."borg-ssh-key".path}";
      repo = "borg@brunol-server:.";
      doInit = true;

      encryption.mode = "none";
      environment.BORG_UNKNOWN_UNENCRYPTED_REPO_ACCESS_IS_OK = "yes";
      compression = "auto,zstd";
      startAt = "daily";
    };
  };
}