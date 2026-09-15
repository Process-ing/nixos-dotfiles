{
  flake.modules.homeManager.brightnessctl = { pkgs, ... }: {
    home.packages = [ pkgs.brightnessctl ];
  };
}