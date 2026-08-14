{
  flake.modules.nixos.network = {

    # Use NetworkManager
    networking.networkmanager.enable = true;
  };
}