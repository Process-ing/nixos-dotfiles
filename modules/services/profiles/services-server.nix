{ self, ... }:

{
  flake.modules.nixos.services-server = {
    imports = with self.modules.nixos; [
      services-console

      nginx
      # network-server

      wifi  # TODO: Remove this
    ];
  };
}