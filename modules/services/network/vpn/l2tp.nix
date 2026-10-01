{
  flake.modules.nixos.l2tp = { pkgs, ... }: {
    networking.networkmanager.plugins = [ pkgs.networkmanager-l2tp ];
  };
}