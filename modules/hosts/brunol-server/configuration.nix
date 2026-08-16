{ inputs, ... }:

{
  flake.modules.nixos.brunol-server = { pkgs, ... }:
  {
    imports = with inputs.self.modules.nixos; [
        temp-de
        temp-display-conf
        temp-system

        system-desktop
    ];
  };
}
