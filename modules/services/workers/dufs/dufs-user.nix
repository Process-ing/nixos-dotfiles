{ self, ... }:

{
  flake.modules = self.lib.mkSystemUser "dufs" 100000;
}