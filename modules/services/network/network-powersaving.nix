{
  flake.modules.nixos.network-powersaving = {
    # Add additional power saving options
    networking.networkmanager.wifi.powersave = true;
  };
}
