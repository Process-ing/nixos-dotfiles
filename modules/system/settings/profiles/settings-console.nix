{ self, ... }:

{
  flake.modules.nixos.settings-console = {
    imports = with self.modules.nixos; [
      fonts
    ];
  };
}
