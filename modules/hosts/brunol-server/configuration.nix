# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, ... }:

{
  flake.modules.nixos.brunol-server = { pkgs, ... }:
  {
    imports = with inputs.self.modules.nixos; [
        temp-de
        temp-display-conf
        temp-shell
        temp-system

        system-desktop
    ];

    # Define users
    users.users.brunol = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };
  };
}
