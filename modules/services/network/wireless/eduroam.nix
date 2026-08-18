{ self, ... }:

{
  flake.modules.nixos.eduroam = { config, lib, ... }: lib.mkMerge [
    {
      # Declare eduroam secrets
      sops.secrets = {
        "wifi/eduroam/identity" = {};
        "wifi/eduroam/password" = {};
      };
    }

    # Declare Wi-Fi config
    (self.lib.mkWifiBase "eduroam" false ''
      
      [wifi-security]
      key-mgmt=wpa-eap

      [802-1x]
      eap=peap;
      identity=${config.sops.placeholder."wifi/eduroam/identity"}
      password=${config.sops.placeholder."wifi/eduroam/password"}
      phase2-auth=mschapv2
    '')
  ];
}