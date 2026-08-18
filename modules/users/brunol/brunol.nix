{ lib, self, ... }:

{
  flake.modules = lib.mkMerge [
    (self.lib.mkUser "brunol" "desktop" true)
    (self.lib.mkSshUser "brunol")
    (self.lib.mkGitUser "brunol" "Process-ing" "42045371")
  ];
}