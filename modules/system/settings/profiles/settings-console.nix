{ self, ... }:

{
  flake.modules.nixos.settings-console = {
    imports = with self.modules.nixos; [
      settings-minimal
      fonts
    ];
  };
}