{
  flake.modules.nixos.distrobox = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.distrobox ];
  };
}
