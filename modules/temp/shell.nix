{
  flake.modules.nixos.temp-shell = { pkgs, ... }:
  {
    environment.systemPackages = with pkgs; [
      fastfetch
    ];
  };
}