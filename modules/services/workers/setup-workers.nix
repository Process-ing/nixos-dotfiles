{
  perSystem = { pkgs, self', ... }: {
    packages.setup-workers = pkgs.writeShellApplication {
      name = "setup-workers";

      runtimeInputs = with self'.packages; [
        setup-cgra
      ];

      text = ''
        setup-cgra
      '';
    };
  };
}