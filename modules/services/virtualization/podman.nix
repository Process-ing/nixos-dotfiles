{
  flake.modules.nixos.podman = {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;  # Create symlink from `docker` to `podman`
    };
  };
}