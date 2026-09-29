{
  flake.modules.nixos.dconf = {
    programs.dconf.enable = true;
  };

  flake.modules.homeManager.dconf = {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}