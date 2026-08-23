{
  perSystem = { pkgs, self', ... }: {
    packages.setup-cgra = pkgs.writeShellApplication {
      name = "setup-cgra";

      runtimeInputs = [ self'.packages.setup-repo ];

      text = ''
        # Check if the target folder exists, and finish if true
        if [ -d /srv/cgra ]; then exit 0; fi

        setup-repo 'git@github.com:Process-ing/feup-cgra' /srv/cgra nginx 500
      '';
    };
  };
}