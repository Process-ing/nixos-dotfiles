{
  flake.modules.homeManager.gtk = { pkgs, ... }: {
    gtk = {
      enable = true;
      colorScheme = "dark";

      theme = {
        name = "Adwaita Dark";
        package = pkgs.gnome-themes-extra;
      };
    };
  };
}
