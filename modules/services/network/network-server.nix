{
  flake.modules.nixos.network-server = {
    
    # Set server static IP
    networking.interfaces.eth0.ipv4.addresses = [{
      address = "192.168.1.42";
      prefixLength = 24;
    }];

    # Configure default gateway
    defaultGateway = {
      address = "192.168.1.1";
      interface = "eth0";
    };
  };
}