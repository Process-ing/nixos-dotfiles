{ self, lib, ... }:

{
  flake.modules.nixos.wifi = lib.mkMerge [
    (self.lib.mkWifi "Apple Watch do Henrique") # Where did the name come from :O
    (self.lib.mkHiddenWifi "NI")
    (self.lib.mkWifi "Studio 26")
  ];
}
