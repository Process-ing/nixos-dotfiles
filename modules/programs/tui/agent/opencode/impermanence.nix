{
  flake.modules.homeManager.opencode = {
    home.persistence."/persistent" = {
      directories = [
        ".local/share/opencode"
        ".local/state/opencode"
      ];
    };
  };
}