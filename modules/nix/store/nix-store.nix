{ self, ... }:

{
  flake.modules.nixos.nix-store = { lib, ... }: {

    # Register NixOS overlays
    nixpkgs.overlays = [ self.overlays.default ];

    # Allow automatic Nix optimization on build
    nix.settings.auto-optimise-store = true;

    # Allow automatic Nix garbage collection
    nix.gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };

    # Whitelist unfree packages
    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "code"
        "firefox-esr-140-bin-unwrapped" # Needed for Zotero
        "intellij-idea"
        "intellij-idea-with-plugins"
        "slack"
        "vscode"
      ];

    # Whitelist insecure packages
    nixpkgs.config.permittedInsecurePackages = [
      "firefox-esr-140-bin-unwrapped-140.17.0esr" # Needed for Zotero
    ];
  };
}
