{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
      openFirewall = true;

      settings = {
        # Force authentication to use SSH keys between non-root users
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };
}