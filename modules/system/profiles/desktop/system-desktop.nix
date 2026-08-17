{ inputs, ... }:

{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-console
      services-desktop
      desktop
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-console
      desktop
    ];
  };
}