{
  flake.modules.homeManager.busybox = { pkgs, ... }: {
    home.packages = [ pkgs.busybox ];
  };
}