{
  flake.modules.homeManager.zen-browser = {
    home.persistence."/persistent" = {
      directories = [
        ".config/zen"
      ];
    };
  };
}