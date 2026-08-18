{
  flake.modules.nixos.dialga = { config, ... }: {
    
    # Declare public keys secrets
    sops.secrets."users/brunol/public_ssh_key" = {};

    # Define SSH authorized keys
    users.users.dialga.openssh.authorizedKeys.keyFiles = [
      config.sops.secrets."users/brunol/public_ssh_key".path
    ];
  };
}