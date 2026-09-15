{
  flake.modules.homeManager.zygarde = {
    home.persistence."/persistent" = {
      directories = [
        "nixos-dotfiles"
      ]
    };
  };
}