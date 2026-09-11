{ inputs, ... }:

{
  flake.modules.homeManager.intellij = { lib, pkgs, ... }: let
    inherit (pkgs.jetbrains) idea;

    plugins = inputs.nix-jetbrains-plugins.lib.pluginsForIde pkgs idea [
      "com.github.catppuccin.jetbrains"
      "com.github.catppuccin.jetbrains_icons"
      "com.github.copilot"
      "org.jetbrains.fortran"
    ];
  in {
    home.packages = [
      (pkgs.jetbrains.plugins.addPlugins idea (lib.attrValues plugins))
    ];
  };
}