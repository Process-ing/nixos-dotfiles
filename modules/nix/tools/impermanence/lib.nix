{
  flake.lib = {
    # Enables some settings if persistence is enabled
    mkIfPersist = config: settings: let
      persistenceBase = if config ? home then config.home else config.persistence;
    in
      if persistenceBase ? persistence then settings else { };
  };
}