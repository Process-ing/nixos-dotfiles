{
  flake.modules.nixos.tailscale = { config, ... }: {
    # Enable tailscale
    services.tailscale.enable = true;

    # Configure firewall
    networking = {
      nftables.enable = true;

      firewall = {
        # Always allow traffic from the Tailscale network
        trustedInterfaces = [ config.services.tailscale.interfaceName ];

        # Allow the Tailscale UDP port through the firewall
        allowedUDPPorts = [ config.services.tailscale.port ];
      };
    };

    # Force tailscaled to use nftables
    systemd.services.tailscaled.serviceConfig.Environment = [
      "TS_DEBUG_FIREWALL_MODE=nftables"
    ];

    # (Optimization) Prevent systemd from waiting for the network online
    systemd.network.wait-online.enable = false;
    boot.initrd.systemd.network.wait-online.enable = false;
  };
}