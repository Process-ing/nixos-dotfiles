{ self, ... }:

{
  flake.modules.nixos.locale-brunol-laptop = { lib, ... }: {
    imports = [
      self.modules.nixos.locale
    ];
    
    # Fix the timezone while I stay in Erasmus
    time.timeZone = lib.mkForce "Europe/Rome";
  };
}