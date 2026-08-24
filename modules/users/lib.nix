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

          # Give user sudo permissions
          extraGroups = [ "wheel" ];
        };

        home-manager.users.${username} = {
          imports = [ self.modules.homeManager.${username} ];
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
    mkSshUser = username: {
      nixos.${username} = { config, ... }: let
        sshFolder = "${config.users.users.${username}.home}/.ssh";
      in
      {
        # Fix SSH folder permissions
        systemd.tmpfiles.settings = {
          "10-ssh-folder" = {
            ${sshFolder} = {
              d = {
                user = "${username}";
                group = "${config.users.users.${username}.group}";
              };
            };
          };
        };

        # Declare private key secret
        sops.secrets."users/${username}/private_ssh_key" = {
          owner = "${username}";
          path = "${sshFolder}/id_ed25519";
        };
      };

      homeManager.${username} = { config, ... }: {

        # Write SSH public key
        home.file.".ssh/id_ed25519.pub".text = "${config.constants.publicKey.${username}}";
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