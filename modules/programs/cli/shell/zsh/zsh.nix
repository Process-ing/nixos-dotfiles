{ self, ... }:

{
  flake.modules.nixos.zsh = { pkgs, ... }: {
    programs.zsh.enable = true;

    # Set zsh as default shell
    users.defaultUserShell = pkgs.zsh;
  };

  flake.modules.homeManager.zsh = { config, pkgs, ...}: {
    imports = with self.modules.homeManager; [
      powerlevel10k
    ];

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
  };
}