{
  flake.modules.nixos.zygarde = { config, ... }: {

    # Define SSH authorized keys
    users.users.zygarde.openssh.authorizedKeys.keys = [
      "${config.constants.publicKey.brunol}"
    ];
  };
}