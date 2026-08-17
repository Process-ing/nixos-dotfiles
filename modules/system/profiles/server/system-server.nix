{ self, ... }:

{
  flake.modules.nixos.system-server = {
    imports = with self.modules.nixos; [
      system-console
      
      services-server

      desktop  # TODO: Remove this
    ];
  };

  flake.modules.homeManager.system-server = {
    imports = with self.modules.homeManager; [
      system-console

      desktop  # TODO: Remove this
    ];
  };
}