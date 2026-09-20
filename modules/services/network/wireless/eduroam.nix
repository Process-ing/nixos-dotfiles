{ self, ... }:

{
  flake.modules.nixos.wifi = { config, ... }: {
    # Declare eduroam secrets
    sops.secrets = {
      "wifi/eduroam/identity" = { };
      "wifi/eduroam/password" = { };
    };

    networking.networkmanager.ensureProfiles = {
      # Use secrets in configuration
      secrets.entries = [
        {
          file = config.sops.secrets."wifi/eduroam/identity".path;
          key = "identity";
          matchId = "eduroam";
          matchType = "wifi";
          matchSetting = "802-1x";
        }
        {
          file = config.sops.secrets."wifi/eduroam/password".path;
          key = "password";
          matchId = "eduroam";
          matchType = "wifi";
          matchSetting = "802-1x";
        }
      ];

      # Define rest of the configuration
      profiles."eduroam" = {
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
          phase2-auth = "mschapv2";
        };
      };
    };
  };
}
