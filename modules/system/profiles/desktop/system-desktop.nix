{ self, ... }:

{
  flake.modules.nixos.system-desktop = {
    imports = with self.modules.nixos; [
      system-console
      services-desktop
      desktop
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with self.modules.homeManager; [
      system-console
      desktop
    ];
  };
}
