{
  flake.modules.nixos.git = {
    programs.git = {
      enable = true;
      config = {
        user = {
          name = "Process-ing";
          email = "42045371+Process-ing@users.noreply.github.com";
        };
        init.defaultBranch = "main";
      };
    };
  };
}