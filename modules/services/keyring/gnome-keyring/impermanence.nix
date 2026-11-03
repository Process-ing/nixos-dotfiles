{ self, ... }:

{
  flake.modules.homeManager.gnome-keyring = self.lib.mkHomePersist {
    directories = [ ".local/share/keyrings" ];
  };
}
