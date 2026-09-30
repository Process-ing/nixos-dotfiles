{
  flake.modules.nixos.brunol = { config, ... }: {
    # Declare inputless SSH key secret
    sops.secrets."users/brunol/private-inputless-ssh-key" = {
      owner = "brunol";
      path = "/home/brunol/.secrets/id_ed25519_inputless";
    };
  };
}