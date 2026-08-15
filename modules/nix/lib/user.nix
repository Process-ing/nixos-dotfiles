{ self, ... }:

{
  config.flake.lib = {
    # Creates the base settings for a user
    mkUser = name: isSudo: {
      nixos.${name} = { lib, ... }:
      {
        users.users.${name} = {
          isNormalUser = true;
          extraGroups = lib.optionals isSudo [
            "wheel"
          ];
        };

        home-manager.users.${name} = {
          imports = [
            self.modules.homeManager.${name}
          ];
        };
      };

      homeManager.${name} = {
        home.username = "${name}";
      };
    };
  };
}