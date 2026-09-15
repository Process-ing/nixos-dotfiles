{
  flake.modules.nixos.sops = { config, ... }: {
    environment.persistence."/persistent" = {
      files = [ config.sops.age.keyFile ];
    };
  };
}