{
  flake.modules.nixos.borg = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.borgbackup ];
  };
}
