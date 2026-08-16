{ self, ... }:

{
  config.flake.lib = {
    # Creates the base settings for a user
    mkUser = username: isSudo: {
      nixos.${username} = { config, lib, ... }: {

        # Make password hash available on user creation
        sops.secrets."users/${username}/password_hash" = {
          neededForUsers = true;
        };

        # NixOS user configuration
        users.users.${username} = {
          isNormalUser = true;
          hashedPasswordFile = config.sops.secrets."users/${username}/password_hash".path;

          extraGroups = lib.optionals isSudo [
            "wheel"
          ];
        };

        home-manager.users.${username} = {
          imports = [
            self.modules.homeManager.${username}
          ];
        };
      };

      # Home Manager user configuration
      homeManager.${username} = {
        home.username = "${username}";
      };
    };

    # Defines SSH settings for a user
    mkSshUser = username: {
      nixos.${username} = { config, ... }: {
      
        # Copy SSH keys from secrets
        sops.secrets."users/${username}/public_ssh_key" = {
          owner = "${username}";
          path = "${config.users.users.${username}.home}/.ssh/id_ed25519.pub";
        };

        sops.secrets."users/${username}/private_ssh_key" = {
          owner = "${username}";
          path = "${config.users.users.${username}.home}/.ssh/id_ed25519";
        };
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