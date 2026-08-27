{ lib, self, ... }:

{
  flake.modules = lib.mkMerge [
    (self.lib.mkUser "zygarde" "server")
    (self.lib.mkSshUser "zygarde")
    (self.lib.mkGitUser "zygarde" "Process-ing" "42045371")
  ];
}