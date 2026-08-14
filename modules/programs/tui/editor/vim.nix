{
  flake.modules.nixos.vim = { pkgs, ... }:
  {
    # Install vim
    environment.systemPackages = with pkgs; [
      vim
    ];

    # Set vim as the default editor
    environment.variables = {
      EDITOR = "vim";
    };
  };
}