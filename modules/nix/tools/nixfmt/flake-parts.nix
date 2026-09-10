{
  perSystem = { pkgs, ... }: {
    # Set as main formatter
    formatter = pkgs.nixfmt-tree;
  };
}