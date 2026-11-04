{
  flake.modules.homeManager.specs = { pkgs, ... }: {
    # Contains packages needed for my work
    home.packages = [ pkgs.nodejs_22 ];
  };
}