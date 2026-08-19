{
  flake.modules.nixos.cresselia = { config, ... }: {

    # Define SSH authorized keys
    users.users.cresselia.openssh.authorizedKeys.keys = [
      "${config.constants.publicKey.brunol}"
    ];
  };
}