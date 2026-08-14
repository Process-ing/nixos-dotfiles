{ inputs, ... }:

{
  flake.modules.nixos.system-console = {
    imports = with inputs.self.modules.nixos; [
      system-minimal
      cli
      tui

      network
    ];
  };
}