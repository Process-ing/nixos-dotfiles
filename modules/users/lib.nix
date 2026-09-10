{ inputs, self, ... }:

{
  config.flake.lib = {

    # Builds the Home Manager configuration for a user
    mkHomeManager = system: name: {
      ${name} = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};

        modules = [ self.modules.homeManager.${name} ];
      };
    };

    # Creates the base settings for a normal user
    mkUser = username: homeProfile: {
      nixos.${username} = { config, lib, ... }: {
        # Make password hash available on user creation
        sops.secrets."users/${username}/password_hash" = {
          neededForUsers = true;
        };

        # NixOS user configuration
        users.users.${username} = {
          isNormalUser = true;
          hashedPasswordFile = config.sops.secrets."users/${username}/password_hash".path;

          # Give user sudo permissions, along with others
          extraGroups = [
            "wheel"
            "network"
          ];
        };

        # Add Home Manager configuration
        home-manager.users.${username} = {
          imports = [ self.modules.homeManager.${username} ];
        };

        # Add personal secrets folder
        systemd.tmpfiles.settings = {
          "10-secrets-folder" = {
            "/home/${username}/.secrets".d = {
              user = "${username}";
              group = "${config.users.users.${username}.group}";
            };
          };
        };
      };

      homeManager.${username} = {

        # Import Home Manager profile
        imports = [ self.modules.homeManager."system-${homeProfile}" ];

        # Define username
        home.username = "${username}";
      };
    };

    # Creates SSH keys for the user
    mkSshUser =
      username:
      let
        identityFilePath = "/home/${username}/.secrets/id_ed25519";
      in
      {
        nixos.${username} = { config, ... }: {

          # Declare identity file secret
          sops.secrets."users/${username}/private_ssh_key" = {
            owner = "${username}";
            path = identityFilePath;
          };
        };

        homeManager.${username} = { config, ... }: {

          # Include Home Manager module
          imports = [ self.modules.homeManager.ssh ];

          # Add identity file to configuration
          programs.ssh.settings."*".IdentityFile = identityFilePath;
        };
      };

    # Defines git user settings
    mkGitUser = username: gitName: gitEmailId: {
      homeManager.${username} = {

        # Configure git user settings
        programs.git.settings.user = {
          name = "${gitName}";
          email = "${gitEmailId}+${gitName}@users.noreply.github.com";
        };
      };
    };
  };
}
