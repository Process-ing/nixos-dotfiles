{
  flake.lib = {
    # Defines module with files and directories to add to permanence
    mkPersist = toPersist@{ files ? [], directories ? [] }: { config, ... }: {
      environment.persistence."/persistent" = toPersist;
    };

    # Same as the previous, but creates a Home Manager module
    mkHomePersist = toPersist@{ files ? [], directories ? [] }: { config, ... }: {
      home.persistence."/persistent" = toPersist;
    };
  };
}