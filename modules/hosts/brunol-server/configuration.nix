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
