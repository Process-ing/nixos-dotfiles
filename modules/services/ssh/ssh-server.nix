{
  flake.modules.nixos.ssh-server = {
    services.openssh = {
      # Define allowed authentication users
      settings.AllowUsers = [ "zygarde" ];
    };
  };
}
