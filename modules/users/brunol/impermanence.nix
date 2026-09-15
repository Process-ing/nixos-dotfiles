{
  flake.modules.homeManager.brunol = {
    home.persistence."/persistent" = {
      directories = [
        "erasmus"
        "nixos-dotfiles"
        "specs"
        "staging"
      ];
    };
  };
}