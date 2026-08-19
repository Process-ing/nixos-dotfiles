{ lib, self, ... }:

{
  flake.modules = lib.mkMerge [
    (self.lib.mkSystemUser "darkrai")
    (self.lib.mkSshUser "darkrai")
    (self.lib.mkGitUser "darkrai" "Process-ing" "42045371")
  ];
}