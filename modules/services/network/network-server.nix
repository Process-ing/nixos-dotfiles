{
  flake.modules.nixos.network-server = {
    networking = {

      # Disable DHPC globally
      useDHCP = false;

      # Set server static IP
      # interfaces.eth0.ipv4.addresses = {
      interfaces.enp12s0.ipv4.addresses = [{
        # address = "192.168.1.42";
        address = "192.168.1.142";
        prefixLength = 24;
      }];

      # Configure default gateway
      defaultGateway = "192.168.1.1";

      # Enable portforwarding
      firewall.allowedTCPPorts = [ 80 443 ];

      # Define /etc/hosts (for debugging purposes)
      # TODO: Remove this
      hosts = {
        "127.0.0.1" = [ "cgra.processing.pt" "sgi.processing.pt" "dufs.processing.pt" ];
      };
    };
  };
}