{ self, ... }:

{
  flake.modules.nixos.wifi = { config, ... }: {
    networking.networkmanager.ensureProfiles.profiles."eduroam" = {
      connection = {
        id = "eduroam";
        type = "wifi";
      };

      wifi = {
        mode = "infrastructure";
        ssid = "eduroam";
      };

      ipv4.method = "auto";

      ipv6 = {
        addr-gen-mode = "stable-privacy";
        method = "auto";
      };

      wifi-security.key-mgmt = "wpa-eap";

      "802-1x" = {
        eap = "peap;";
        identity = "$EDUROAM_IDENTITY";
        password = "$EDUROAM_PASSWORD";
        phase2-auth = "mschapv2";
      };
    };
  };
}
