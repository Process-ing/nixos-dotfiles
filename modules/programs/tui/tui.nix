{ inputs, ... }:

{
  flake.modules.nixos.tui = {
    imports = with inputs.self.modules.nixos; [
      vim
    ];
  };
}