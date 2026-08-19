{ self, ... }:

{
  flake.modules = self.lib.mkSystemUser "darkrai";
}