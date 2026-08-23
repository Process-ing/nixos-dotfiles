{
  perSystem = { pkgs, self', ... }: {
    packages.setup-workers = pkgs.writeShellApplication {
      name = "setup-workers";

      runtimeInputs = with self'.packages; [
        setup-cgra
        setup-sgi
      ];

      text = ''
        setup-cgra
        setup-sgi
      '';
    };
  };
}