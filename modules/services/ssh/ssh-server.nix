{
  flake.modules.nixos.ssh-server = {
    services.openssh = {
      # Change SSH port
      ports = [ 4222 ];

      # Define allowed authentication users
      settings.AllowUsers = [ "dialga" ];
    };
  };
}