{ lib, self, ... }:

{
  flake.modules = lib.mkMerge [
    (self.lib.mkUser "brunol" true)
    (self.lib.mkSshUser "brunol")
    (self.lib.mkGitUser "brunol" "Process-ing" "42045371")
    {
      homeManager.brunol = {
        imports = with self.modules.homeManager; [
          system-desktop
        ];
      };
    }
  ];
}