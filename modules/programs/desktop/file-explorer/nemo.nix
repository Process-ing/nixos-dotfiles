{
  flake.modules.homeManager.nemo = { pkgs, ... }: {
    home.packages = [ pkgs.nemo-with-extensions ];
  };
}