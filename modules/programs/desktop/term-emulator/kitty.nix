{
  flake.modules.homeManager.kitty = { pkgs, ... }: {
    programs.kitty = {
      enable = true;
      font.name = "JetBrainsMono NF";
    };
  };
}