{
  flake.modules.nixos.brightnessctl = { pkgs, ... }: let
    lightLevel = "20%";
  in {
    environment.systemPackages = [ pkgs.brightnessctl ];

    # Set preferred brightness at startup
    systemd.user.services.set-brightness = {
      enable = true;
      wantedBy = [ "default.target" ];
      serviceConfig.Type = "oneshot";

      path = [ pkgs.brightnessctl ];

      script = ''
        brightnessctl -d intel_backlight set ${lightLevel}
      '';
    };
  };
}