{ lib, self, ... }:

{
  config.flake.lib = {
    # Create a Wi-Fi profile boilerplate
    mkWifiBase = ssid: isHidden: configSuffix: {
      # Create the Wi-Fi configuration as a template
      sops.templates."${ssid}.nmconnection" = {
        path = "/etc/NetworkManager/system-connections/${ssid}.nmconnection";

        content = ''
          [connection]
          id=${ssid}
          type=wifi

          [wifi]${lib.optionalString isHidden "\nhidden=true"}
          mode=infrastructure
          ssid=${ssid}

          [ipv4]
          method=auto

          [ipv6]
          addr-gen-mode=stable-privacy
          method=auto

          [proxy]
        ''
        + configSuffix;
      };
    };

    # Create a standard secure Wi-Fi profile
    # There must be present a secret "wifi/<ssid>" with the Wi-Fi password
    mkWifi =
      ssid: isHidden:
      { config, ... }:
      lib.mkMerge [
        {
          # Declare Wi-Fi password secret
          sops.secrets."wifi/${ssid}" = { };
        }

        (self.lib.mkWifiBase ssid isHidden ''

          [wifi-security]
          auth-alg=open
          key-mgmt=wpa-psk
          psk=${config.sops.placeholder."wifi/${ssid}"}
        '')
      ];
  };
}
