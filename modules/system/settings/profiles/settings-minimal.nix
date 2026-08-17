{ self, ... }:

{
  flake.modules.nixos.settings-minimal = {
    imports = with self.modules.nixos; [
      grub
      keyboard
      locale
    ];
  };
}