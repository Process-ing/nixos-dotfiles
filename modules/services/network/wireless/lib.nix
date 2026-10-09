{ lib, self, ... }:

{
  config.flake.lib =
    let
      mkWifiId = ssid: builtins.replaceStrings [ " " ] [ "-" ] (lib.toLower ssid);
      mkWifiPassVar = ssid: "$" + (builtins.replaceStrings [ " " ] [ "_" ] (lib.toUpper ssid));
    in
    {
      # Create a standard secure Wi-Fi profile
      # There must be present a line "$SSID_IN_UPPERCASE_WITH_UNDERSCORES=..."
      # with the Wi-Fi password in the Wi-Fi .env secret
      mkWifi =
        ssid:
        { config, ... }:
        let
          id = mkWifiId ssid;
          wifiPassVar = mkWifiPassVar ssid;
        in
        {
          networking.networkmanager.ensureProfiles.profiles.${id} = {
            connection = {
              inherit id;
              type = "wifi";
            };

            wifi = {
              mode = "infrastructure";
              inherit ssid;
            };

            ipv4.method = "auto";

            ipv6 = {
              addr-gen-mode = "stable-privacy";
              method = "auto";
            };

            wifi-security = {
              auth-alg = "open";
              key-mgmt = "wpa-psk";
              psk = wifiPassVar;
            };
          };
        };

      mkHiddenWifi =
        ssid:
        let
          id = mkWifiId ssid;
        in
        lib.mkMerge [
          (self.lib.mkWifi ssid)
          {
            networking.networkmanager.ensureProfiles.profiles.${id}.wifi.hidden = "yes";
          }
        ];
    };
}
