{
  flake.modules.nixos.docker = {
    virtualisation.docker = {
      enable = true;

      # Configure rootless docker
      rootless = {
        enable = true;
        setSocketVariable = true;  # Configures DOCKER_HOST to point to the rootless Docker instance       
      };
    };
  };
}