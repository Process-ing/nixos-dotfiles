{ lib, self, ... }:

{
  config.flake.lib = {
    # Create a Wi-Fi profile boilerplate
    mkWifiBoilerplate = ssid: {
      "${ssid}" = {
        connection = {
          id = "${ssid}";
          type = "wifi";
        };

        ipv4 = {
          method = "auto";
        };

        ipv6 = {
          addr-gen-mode = "stable-privacy";
          method = "auto";
        };

        wifi = {
          mode = "Infrastructure";
          ssid = "${ssid}";
        };
      };
    };

    # Create a standard secure Wi-Fi profile
    # The Wi-Fi password must be declared in the secrets file and identified
    # using the SSID in UPPER_SNAKE_CASE
    mkWifi = ssid: let
      toUpperSnakeCase = name: builtins.replaceStrings [ " " "-" ] [ "_" "_" ] (lib.toUpper name);
      passwordName = toUpperSnakeCase ssid;
    in lib.mkMerge [
      (self.lib.mkWifiBoilerplate ssid)
      {
        "${ssid}" = {
          wifi-security = {
            auth-alg = "open";
            key-mgmt = "wpa-psk";
            psk = "$${passwordName}";
          };
        };
      }
    ];
  };
}