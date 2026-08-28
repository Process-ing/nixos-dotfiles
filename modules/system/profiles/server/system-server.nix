{ self, ... }:

{
  flake.modules.nixos.system-server = {
    imports = with self.modules.nixos; [
      system-console
      services-server
    ];
  };

  flake.modules.homeManager.system-server = {
    imports = with self.modules.homeManager; [
      system-console
    ];
  };
}