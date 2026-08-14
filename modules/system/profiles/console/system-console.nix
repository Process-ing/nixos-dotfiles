{ inputs, ... }:

{
  flake.modules.nixos.system-console = {
    imports = with inputs.self.modules.nixos; [
      system-minimal
      home-manager
      cli
      tui

      network
    ];
  };

  flake.modules.homeManager.system-console = {
    imports = with inputs.self.modules.homeManager; [
      system-minimal
    ];
  };
}