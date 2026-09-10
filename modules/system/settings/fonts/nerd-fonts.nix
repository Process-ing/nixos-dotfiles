{
  flake.modules.nixos.nerd-fonts = { pkgs, ... }: {
    fonts.packages = with pkgs.nerd-fonts; [
      fira-code
      jetbrains-mono
    ];
  };
}
