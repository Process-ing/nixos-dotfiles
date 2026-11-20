{
  flake.modules.homeManager.mindustry = { pkgs, ... }: {
    home.packages = [ pkgs.mindustry ];
  };
}