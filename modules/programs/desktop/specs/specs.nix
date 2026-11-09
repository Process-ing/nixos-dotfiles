{ self, ... }:

{
  flake.modules.homeManager.specs = { pkgs, ... }: {
    # Contains packages needed for my work

    imports = with self.modules.homeManager; [
      intellij
      jetbrains-impermanence
    ];

    home.packages = with pkgs; [ nodejs_22 python3 zotero ];
  };
}