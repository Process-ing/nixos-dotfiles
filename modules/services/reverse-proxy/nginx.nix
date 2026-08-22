{
  flake.modules.nixos.nginx = {
    services.nginx = {
      enable = true;

      # Use recommended settings
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      # Add default 404 page
      virtualHosts.localhost = {
        default = true;
        locations."/" = {
          return = "404";
        };
      };
    };
  };
}