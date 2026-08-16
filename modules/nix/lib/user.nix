{ self, ... }:

{
  config.flake.lib = {
    # Creates the base settings for a user
    mkUser = username: isSudo: {
      nixos.${username} = { config, lib, ... }:
      {
        # Make password hash available on user creation
        sops.secrets."users/${username}/password_hash".neededForUsers = true;

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