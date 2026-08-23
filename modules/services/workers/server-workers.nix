{ self, ... }:

{
  flake.modules.nixos.server-workers = {
    imports = with self.modules.nixos; [
      cgra-worker
    ];

    services.cgra-worker = {
      enable = true;
      domain = "cgra.processing.pt";
    };
  };
}