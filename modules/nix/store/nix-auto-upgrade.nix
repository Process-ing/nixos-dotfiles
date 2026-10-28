{ self, ... }:

{
  flake.modules.nixos.nix-auto-upgrade = { config, ... }: {
    # Declare automatic system upgrades
    system.autoUpgrade = {
      enable = true;
      flake = self.outPath;
      flags = [
        "--print-build-logs"
        "--commit-lock-file"
      ];
      dates = "08:00";
      randomizedDelaySec = "45min";
      persistent = true;
    };

    # Set git credentials
    systemd.services.nixos-upgrade.environment =
      let
        brunolConfig = config.home-manager.users.brunol;
        brunolGitConfig = brunolConfig.programs.git.settings.user;
      in
      {
        GIT_AUTHOR_NAME = brunolGitConfig.name;
        GIT_AUTHOR_EMAIL = brunolGitConfig.email;
        GIT_COMMITTER_NAME = brunolGitConfig.name;
        GIT_COMMITTER_EMAIL = brunolGitConfig.email;
      };

    # Fix "repository is not owned by current user" error
    home-manager.users.root = {
      imports = [ self.modules.homeManager.home-manager ];

      home.file.".gitconfig".text = ''
        [safe]
          directory = ${self.outPath}
      '';
    };
  };
}
