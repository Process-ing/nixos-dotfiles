{ self, ... }:

{
  flake.modules.homeManager.feup-vpn = self.lib.mkHomePersist {
    files = [ ".gp-saml-gui-cookies" ];
  };
}