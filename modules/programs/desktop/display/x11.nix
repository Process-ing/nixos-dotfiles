{
  flake.modules.homeManager.x11 = { pkgs, ... }: {
    home.packages = with pkgs; [
      xclip
      xkill
    ];
  };
}