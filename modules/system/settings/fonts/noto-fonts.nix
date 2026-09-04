{
  flake.modules.nixos.noto-fonts = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
    ];
  };
}