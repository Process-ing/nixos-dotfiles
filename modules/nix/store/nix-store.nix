{ self, ... }:

{
  flake.modules.nixos.nix-store = {

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
  };
}
