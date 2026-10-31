{ self, ... }:

{
  flake.modules.homeManager.gnome-keyring = self.lib.mkHomeManager {
    directories = [ ".local/share/keyrings" ]
  };
}