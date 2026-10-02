{
  flake.modules.homeManager.kitty = { pkgs, ... }: {
    programs.kitty = {
      enable = true;
      font.name = "JetBrainsMono NF";
      extraConfig = ''
        background_opacity 0.60
      '';
    };
  };
}
