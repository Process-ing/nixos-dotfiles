{ inputs, ... }:

{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-console
      desktop
    ];
  };
}