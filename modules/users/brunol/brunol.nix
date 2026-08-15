{ self, lib, ... }:

{
  flake.modules = lib.mkMerge [
    (self.lib.mkUser "brunol" true)
    (self.lib.mkGitUser "brunol" "Process-ing" "42045371+Process-ing@users.noreply.github.com")
    {
      homeManager.brunol = {
        imports = with self.modules.homeManager; [
          system-desktop
        ];
      };
    }
  ];
}