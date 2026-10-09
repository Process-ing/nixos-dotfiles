{
  flake.modules.homeManager.gnome-keyring = { pkgs, ... }: {
    services.gnome-keyring.enable = true;

    home.packages = [ pkgs.gcr_4 ]; # Provides org.gnome.keyring.SystemPrompter
  };
}
