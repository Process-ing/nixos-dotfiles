{ self, ... }:

{
  flake.modules.nixos.system-console = {
    imports = with self.modules.nixos; [
      system-minimal

      settings-console
      services-console

      nix-tools
      cli
      tui
    ];
  };

  flake.modules.homeManager.system-console = {
    imports = with self.modules.homeManager; [
      system-minimal

      nix-tools
      cli
      tui
    ];
  };
}
