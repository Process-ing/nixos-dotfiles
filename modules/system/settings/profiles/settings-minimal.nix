{ self, ... }:

{
  flake.modules.nixos.settings-minimal = {
    imports = with self.modules.nixos; [
      keyboard
      locale
      sudo
      systemd-boot
      touchpad
    ];
  };
}
