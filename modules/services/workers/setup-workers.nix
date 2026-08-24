{
  perSystem = { pkgs, self', ... }: {
    packages.setup-workers = pkgs.writeShellApplication {
      name = "setup-workers";

      runtimeInputs = with self'.packages; [
        setup-cgra
        setup-sgi
        setup-overleaf
      ];

      text = ''
        setup-cgra
        setup-sgi
        setup-overleaf
      '';
    };
  };
}