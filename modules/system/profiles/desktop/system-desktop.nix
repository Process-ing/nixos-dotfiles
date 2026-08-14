{ inputs, ... }:

{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-console
      desktop
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-console
    ];
  };
}