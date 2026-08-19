{
  flake.modules.nixos.docker = {
    virtualisation.docker = {
      # Disable rootful Docker
      enable = false;

      # Configure rootless docker
      rootless = {
        enable = true;
        setSocketVariable = true;  # Configures DOCKER_HOST to point to the rootless Docker instance       
      };
    };
  };
}