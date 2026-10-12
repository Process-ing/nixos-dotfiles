{
  flake.modules.nixos.feup-vpn = { config, pkgs, ... }: {
    # Declare needed secrets
    sops.secrets."vpn/feup-vpn/username" = { };
    sops.secrets."vpn/feup-vpn/password" = { };

    # Install necessary packages for PPTP network
    environment.systemPackages = [ pkgs.pptp pkgs.ppp ];

    # Boot PPP kernel module
    boot.kernelModules = [ "ppp_mppe" ];

    # Create VPN peer file
    sops.templates."feup-vpn-peer" = {
      path = "/etc/ppp/peers/feup";
      content = ''
        pty "${pkgs.pptp}/bin/pptp feup-vpn.up.pt --nolaunchpppd"
        name ${config.sops.placeholder."vpn/feup-vpn/username"}
        remotename PPTP
        require-mppe-128
        refuse-pap
        refuse-chap
        refuse-mschap
        refuse-eap
        noauth
        nodeflate
        nobsdcomp
        defaultroute
        usepeerdns
      '';
    };

    # Declare VPN password
    sops.templates."chap-secrets" = {
      path = "/etc/ppp/chap-secrets";
      content = ''
        "${config.sops.placeholder."vpn/feup-vpn/username"}" PPTP "${config.sops.placeholder."vpn/feup-vpn/password"}" *
      '';
    };
  };
}