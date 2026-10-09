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
        "idea"
        "idea-with-plugins"
        "slack"
        "vscode"
      ];
  };
}
