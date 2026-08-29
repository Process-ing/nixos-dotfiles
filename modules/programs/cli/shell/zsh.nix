{
  flake.modules.nixos.zsh = { pkgs, ... }: {
    programs.zsh.enable = true;

    # Set zsh as default shell
    users.defaultUserShell = pkgs.zsh;
  };

  flake.modules.homeManager.zsh = {
    programs.zsh = {
      enable = true;
    };
  };
}