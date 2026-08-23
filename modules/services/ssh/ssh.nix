{
  flake.modules.nixos.ssh = { config, ... }: {
    # Configure OpenSSH
    services.openssh = {
      enable = true;
      openFirewall = true;

      settings = {
        # Force authentication to use SSH keys between non-root users
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
      };
      
      # Define system-wide known hosts
      knownHosts = {
        "github.com".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      };
    };

    # Configure SSH agent
    programs.ssh = {
      startAgent = true;
      enableAskPassword = true;
    };
  };
}