{
  flake.modules.nixos.network = {
    environment.persistence."/persistent" = {
      directories = [
        "/etc/NetworkManager/system-connections"
      ];
    };
  };
}