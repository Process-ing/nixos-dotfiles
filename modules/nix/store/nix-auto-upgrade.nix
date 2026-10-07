{
  flake.modules.nixos.nix-auto-upgrade = {
    # Declare automatic system upgrades
    system.autoUpgrade = {
      enable = true;
      flake = "/home/brunol/nixos-dotfiles";
      flags = [
        "--print-build-logs"
        "--commit-lock-file"
      ];
      dates = "daily";
      randomizedDelaySec = "45min";
    };
  };
}