{
  flake.modules.homeManager.zsh = {
    home.persistence."/persistent" = {
      files = [
        ".zsh_history"
      ];
    };
  };
}