{ self, lib, ... }:

{
  flake.modules.nixos.wifi = lib.mkMerge [
    {
      imports = with self.modules.nixos; [
        eduroam
      ];
    }

    (self.lib.mkWifi "Apple Watch do Henrique" false)  # Where did the name come from :O
    (self.lib.mkWifi "NI" true)
  ];
}