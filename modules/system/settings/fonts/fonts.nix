{ self, ... }:

{
  flake.modules.nixos.fonts = {
    imports = with self.modules.nixos; [
      nerd-fonts
      noto-fonts
    ];
  };
}
