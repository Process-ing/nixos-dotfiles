{ self, ... }:

{
  flake.modules.nixos.settings-minimal = {
    imports = with self.modules.nixos; [
      keyboard
      locale
      systemd-boot
      touchpad
    ];
  };
}
