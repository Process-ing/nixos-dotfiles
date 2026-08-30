{
  flake.modules.homeManager.powerlevel10k = { pkgs, ... }: {

    # Install powerlevel10k
    home.file.".oh-my-zsh/custom/themes/powerlevel10k".source = pkgs.fetchFromGitHub {
      owner = "romkatv";
      repo = "powerlevel10k";
      rev = "3308262dfbd743b6e1d3956a2b5572f7a049d692";
      sha256 = "sha256-s0FLaSZdhMTJyHQFtkQWdp0Qi2QAZvy4H40r1FdEOvY=";
    };

    # Configure theme
    programs.zsh.initContent = "source ${./.p10k.zsh}";
  };
}