{
  flake.modules.nixos.l2tp = { pkgs, ... }: {
    # Enable Libreswan
    services.libreswan.enable = true;

    # Install plugin
    networking.networkmanager.plugins = [ pkgs.networkmanager-l2tp ];
  };
}