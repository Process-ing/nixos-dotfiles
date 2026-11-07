{
  flake.modules.homeManager.feup-vpn = { pkgs, ... }: let
    feupVpnCmd = pkgs.writeShellApplication {
      name = "feup-vpn";
      runtimeInputs = [ pkgs.gp-saml-gui ];
      text = ''
        gp-saml-gui --gateway -S vpn.up.pt --no-verify -- \
          --servercert=pin-sha256:NZzQLvAC9A43iO0QKxiztpZYJVeIakVZZG9HwcH8Fcg=
      '';
    };
  in {
    home.packages = [ feupVpnCmd ];
  };
}