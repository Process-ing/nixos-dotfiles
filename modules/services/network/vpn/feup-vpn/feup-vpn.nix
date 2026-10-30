{
  flake.modules.homeManager.feup-vpn = { pkgs, ... }: let
    feupVpnCmd = pkgs.writeShellApplication {
      name = "feup-vpn";
      runtimeInputs = [ pkgs.gp-saml-gui ];
      text = ''
        gp-saml-gui --gateway -S vpn.up.pt --no-verify -- \
          --servercert=pin-sha256:oEmSQLdDQ91Hph9pSFjkS5N52BSSCMNsgmOGbtDXcbA=
      '';
    };
  in {
    home.packages = [ feupVpnCmd ];
  };
}