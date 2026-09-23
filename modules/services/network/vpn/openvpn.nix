{
  flake.modules.nixos.openvpn = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.networkmanager-openvpn ];
  };
}