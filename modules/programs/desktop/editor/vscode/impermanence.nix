{
  flake.modules.homeManager.vscode = {
    home.persistence."/persistent" = {
      directories = [
        ".vscode/extensions"
      ];
    };
  };
}