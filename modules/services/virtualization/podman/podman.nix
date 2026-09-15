{
  flake.modules.nixos.podman = { pkgs, ... }: {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true; # Create symlink from `docker` to `podman`
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    # Set Podman as the backend for oci-containers (redundant)
    virtualisation.oci-containers.backend = "podman";

    # Configure default registries
    virtualisation.containers.registries.settings.unqualified-search-registries = [
      "docker.io"
    ];

    # Use docker-compose
    environment.systemPackages = with pkgs; [
      docker-compose
    ];

    # Disable podman-compose warning
    environment.sessionVariables = {
      PODMAN_COMPOSE_WARNING_LOGS = "false";
    };
  };
}
