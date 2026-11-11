{ self, ... }:

{
  flake.modules.homeManager.specs = { lib, pkgs, ... }: {
    # Contains packages needed for my work
    imports = with self.modules.homeManager; [
      intellij
      jetbrains-impermanence
      zotero
    ];

    home.file.".npmrc".text = ''
      prefix = ${"\${HOME}/.npm-packages"}
    '';

    programs.zsh.initContent = lib.mkAfter ''
      export PATH=$HOME/.npm-packages/bin:$PATH
      export NODE_PATH=~/.npm-packages/lib/node_modules
    '';
  };
}