{ self, ... }:

{
  flake.modules = lib.mkMerge [
    (self.lib.mkUser "brunol" true)
    {
      homeManager.brunol = {
        imports = with self.modules.homeManager; [
          system-desktop
        ];
      };
    }
  ];
}