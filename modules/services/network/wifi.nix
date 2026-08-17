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
        (self.lib.mkWifi "Apple Watch do Henrique")  # Where did the name come from :O
        (self.lib.mkWifi "NI")
      ];
    };
  };
}