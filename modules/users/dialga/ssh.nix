{
  flake.modules.nixos.dialga = { config, ... }: {

    # Define SSH authorized keys
    users.users.dialga.openssh.authorizedKeys.keys = [
      "${config.constants.publicKey.brunol}"
    ];
  };
}