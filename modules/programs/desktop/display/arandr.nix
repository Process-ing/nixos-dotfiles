{
  flake.modules.homeManager.arandr = { pkgs, ... }: {
    home.packages = [ pkgs.arandr ];
  };
}