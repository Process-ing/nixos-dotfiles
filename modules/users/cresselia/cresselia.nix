{ lib, self, ... }:

{
  flake.modules = lib.mkMerge [
    (self.lib.mkUser "cresselia" "server")
    (self.lib.mkSshUser "cresselia")
    (self.lib.mkGitUser "cresselia" "Process-ing" "42045371")
  ];
}