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
  };

  flake.modules.homeManager.ssh = {

    # Define SSH configurations
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      settings = {
        
        # Default settings
        "*" = {
          ForwardAgent = false;
          AddKeysToAgent = "yes";
          Compression = false;
          ServerAliveInterval = 0;
          ServerAliveCountMax = 3;
          HashKnownHosts = false;
          UserKnownHostsFile = "~/.ssh/known_hosts";
          ControlMaster = "no";
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = "no";
        };
      };
    };

    # Enable SSH agent
    services.ssh-agent = {
      enable = true;
      defaultMaximumIdentityLifetime = 3600;
    };
  };
}