{ lib, self, ... }:

{
  flake.modules = lib.mkMerge [
    (self.lib.mkUser "dialga" "server" true)
    (self.lib.mkSshUser "dialga")
    (self.lib.mkGitUser "dialga" "Process-ing" "42045371")
  ];
}