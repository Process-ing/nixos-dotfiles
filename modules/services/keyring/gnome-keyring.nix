{
  flake.modules.nixos.gnome-keyring = {
    services.gnome = {
      gnome-keyring.enable = true;
      gcr-ssh-agent.enable = false;  # Conflicts with SSH agent
    };
  };
}
