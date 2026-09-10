{ self, ... }:

{
  flake.modules.nixos.settings-minimal = {
    imports = with self.modules.nixos; [
      systemd-boot
      keyboard
      locale
    ];
  };
}
