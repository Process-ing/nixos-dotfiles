{ self, ... }:

{
  flake.modules.nixos.wifi = { config, lib, ... }: {
    # Declare passwords secret
    sops.secrets.wifi = {};
    
    netwroking.networkmanager.ensureProfiles = {
      
      # Specify passwords file
      environmentFiles = [ config.sops.secrets.wifi.path ];

      # Configure Wi-Fi profiles
      profiles = lib.mkMerge [
        # Standard networks
        (self.lib.mkWifi "Apple Watch do Henrique")  # Where did the name come from :O
        (self.lib.mkWifi "NI")
        (self.lib.mkWifiBoilerplate "eduroam")

        # Custom Wi-Fi security specification
        {
          eduroam = {
            wifi-security = {
              key-mgmt = "wpa-eap";
            };

            "802-1x" = {
              eap = "peap;";
              identity = "$EDUROAM_IDENTITY";
              password = "$EDUROAM_PASSWORD";
              phase2-auth = "mschapv2";
            };
          };
        }
      ];
    };
  };
}