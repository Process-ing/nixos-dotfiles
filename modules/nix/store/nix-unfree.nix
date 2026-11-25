{
  # Defines whitelist of unfree packages
  flake.modules.nixos.nix-unfree = { lib, ... }: {
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "code"
        "firefox-esr-140-bin-unwrapped" # Needed for Zotero
        "intellij-idea"
        "intellij-idea-with-plugins"
        "nvidia-x11"
        "nvidia-settings"
        "nvidia-kernel-modules"
        "slack"
        "vscode"
      ];
  };
}