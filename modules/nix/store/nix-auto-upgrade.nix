{
  flake.modules.nixos.nix-auto-upgrade = { config, ... }: {
    # Declare automatic system upgrades
    system.autoUpgrade = {
      enable = true;
      flake = "/home/brunol/nixos-dotfiles";
      flags = [
        "--print-build-logs"
        "--commit-lock-file"
      ];
      dates = "daily";
      randomizedDelaySec = "45min";
    };

    # Set git credentials
    systemd.services.nixos-upgrade.environment = let
      brunolConfig = config.home-manager.users.brunol;
      brunolGitConfig = brunolConfig.programs.git.settings.user;
    in {
      GIT_AUTHOR_NAME = brunolGitConfig.name;
      GIT_AUTHOR_EMAIL = brunolGitConfig.email;
      GIT_COMMITTER_NAME = brunolGitConfig.name;
      GIT_COMMITTER_EMAIL = brunolGitConfig.email;
    };
  };
}