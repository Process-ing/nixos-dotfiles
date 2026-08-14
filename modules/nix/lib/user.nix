{ self, ... }:

{
  config.flake.lib = {
    # Creates the base settings for a user
    mkUser = username: isSudo: {
      nixos.${username} = { lib, ... }:
      {
        users.users.${username} = {
          isNormalUser = true;
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

      homeManager.${username} = {
        home.username = ${username};
      };
    };
  };
}