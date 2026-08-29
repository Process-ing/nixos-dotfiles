{
  flake.modules.nixos.zsh = { pkgs, ... }: {
    programs.zsh.enable = true;

    # Set zsh as default shell
    users.defaultUserShell = pkgs.zsh;
  };

  flake.modules.homeManager.zsh = { config, pkgs, ...}: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history.ignorePatterns = [ "rm *" "pkill *" ];

      # Oh My Zsh configuration
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        custom = "${config.home.homeDirectory}/.oh-my-zsh/custom";
        theme = "powerlevel10k/powerlevel10k";
      };
    };

    # Install powerlevel10k
    home.file.".oh-my-zsh/custom/themes/powerlevel10k".source = pkgs.fetchFromGitHub {
      owner = "romkatv";
      repo = "powerlevel10k";
      rev = "3308262dfbd743b6e1d3956a2b5572f7a049d692";
      sha256 = "sha256-s0FLaSZdhMTJyHQFtkQWdp0Qi2QAZvy4H40r1FdEOvY=";
    };
  };
}