{ self, ... }:

{
  flake.modules.nixos.server-workers = {
    imports = with self.modules.nixos; [
      cgra-worker
    ];

    # Define SSL secrets
    sops.secrets = {
      "nginx/ssl_certificate" = {
        owner = "nginx";
      };
    
      "nginx/ssl_certificate_key" = {
        owner = "nginx";
      };
    };

    # Configure services

    services.cgra-worker = {
      enable = true;
      domain = "cgra.processing.pt";
    };
  };
}