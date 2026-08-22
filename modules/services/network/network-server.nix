{
  flake.modules.nixos.network-server = {
    networking = {

      # Set server static IP
      # interfaces.eth0.ipv4.addresses = [{
      interfaces.enp12s0.ipv4.addresses = [{
        # address = "192.168.1.42";
        address = "192.168.1.142";
        prefixLength = 24;
      }];

      # Configure default gateway
      defaultGateway = {
        address = "192.168.1.1";
        interface = "eth0";
      };

      # Enable portforwarding
      firewall.allowedTCPPorts = [ 80 443 ];
    };
  };
}