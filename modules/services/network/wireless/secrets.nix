{
  flake.modules.nixos.wifi = { config, ... }: {
    # Declare Wi-Fi env secret
    sops.secrets."wifi-env" = { };

    # Use the environment file
    networking.networkmanager.ensureProfiles.environmentFiles = [
      config.sops.secrets."wifi-env".path
    ];
  };
}
