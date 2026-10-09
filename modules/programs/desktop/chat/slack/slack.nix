{
  flake.modules.homeManager.slack = { pkgs, ... }: {
    home.packages = [ pkgs.slack ];
  };
}
