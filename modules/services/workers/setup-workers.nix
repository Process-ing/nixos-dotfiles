{
  perSystem = { pkgs, self', ... }: {
    packages.setup-workers = pkgs.writeShellScriptBin "setup-workers" ''
      ${self'.packages.setup-cgra}/bin/setup-cgra
    '';
  };
}