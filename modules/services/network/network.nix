{
  flake.modules.nixos.network = {
    networking = {
      
      # Use NetworkManager
      networkmanager.enable = true;

      # Enable firewall (redundant since it is on by default)
      firewall.enable = true;
    };
  };
}