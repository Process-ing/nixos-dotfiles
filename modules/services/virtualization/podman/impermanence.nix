{
  flake.modules.nixos.podman = {
    environment.persistence."/persistent" = {
      directories = [
        "/var/lib/containers/storage"
      ];
    };
  };

  flake.modules.homeManager.podman = {
    home.persistence."/persistent" = {
      directories = [
        ".local/share/containers/storage"
      ];
    };
  };
}