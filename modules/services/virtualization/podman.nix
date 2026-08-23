{
  flake.modules.nixos.podman = {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;  # Create symlink from `docker` to `podman`
    };

    # Set Podman as the backend for oci-containers (redundant)
    virtualisation.oci-containers.backend = "podman";  
  };
}