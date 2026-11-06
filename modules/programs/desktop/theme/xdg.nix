{
  flake.modules.nixos.xdg = {
    # Enabling XDG portal via Home Manager requires this
    environment.pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
  };

  flake.modules.homeManager.xdg = { pkgs, ... }: {
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

      config = {
        common.default = [ "gtk" ];
      };
    };
  };
}