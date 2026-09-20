{ lib, self, ... }:

{
  config.flake.lib = let
    mkWifiId = ssid: builtins.replaceStrings [ " " ] [ "-" ] (lib.toLower ssid);
  in {
    # Create a standard secure Wi-Fi profile
    # There must be present a secret "wifi/<ssid>" with the Wi-Fi passwor
    mkWifi = ssid: { config, ... }: let 
      id = mkWifiId ssid;
    in {
      # Declare Wi-Fi password secret
      sops.secrets."wifi/${id}" = { };

      networking.networkmanager.ensureProfiles = {
        # Specify password in configuration
        secrets.entries = [
          {
            file = config.sops.secrets."wifi/${id}".path;
            key = "psk";
            matchId = id;
            matchType = "wifi";
            matchSetting = "wifi-security";
          }
        ];

        # Declare Wi-Fi properties
        profiles.${id} = {
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
          };
        };
      };
    };

    mkHiddenWifi = ssid: let
      id = mkWifiId ssid;
    in lib.mkMerge [
      (self.lib.mkWifi ssid)
      {
        networking.networkmanager.ensureProfiles.profiles.${id}.wifi.hidden = "yes";
      }
    ];
  };
}
