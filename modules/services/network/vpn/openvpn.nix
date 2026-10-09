{
  flake.modules.nixos.openvpn = { pkgs, ... }: {
    networking.networkmanager.plugins = [ pkgs.networkmanager-openvpn ];

    programs.openvpn3.enable = true;
  };
}
