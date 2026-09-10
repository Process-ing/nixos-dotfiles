{
  flake.modules.nixos.network = {
    networking = {

      # Use NetworkManager
      networkmanager.enable = true;

      # Enable firewall (redundant since it is on by default)
      firewall.enable = true;

      # Define nameservers
      nameservers = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
  };
}
