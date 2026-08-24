{ self, ... }:

{
  flake.modules.nixos.server-workers = {
    imports = with self.modules.nixos; [
      cgra-worker
      sgi-worker
      dufs-worker
      overleaf-worker

      system-user-registry  # Dependency
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

    services = {
      cgra-worker = {
        enable = true;
        domain = "cgra.processing.pt";
      };

      sgi-worker = {
        enable = true;
        domain = "sgi.processing.pt";
      };

      dufs-worker = {
        enable = true;
        port = 5000;
        domain = "dufs.processing.pt";
      };

      overleaf-worker = {
        enable = true;
        port = 5001;
        domain = "overleaf.processing.pt";
      };
    };
  };
}