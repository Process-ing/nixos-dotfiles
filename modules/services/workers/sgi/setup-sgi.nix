{
  perSystem = { pkgs, self', ... }: {
    packages.setup-sgi = pkgs.writeShellApplication {
      name = "setup-sgi";

      runtimeInputs = [ self'.packages.setup-repo ];

      text = ''
        # Check if the target folder exists, and finish if true
        if [ -d /srv/sgi ]; then exit 0; fi

        setup-repo 'git@github.com:Process-ing/feup-sgi' /srv/sgi nginx 500
      '';
    };

    services.setup-workers.scripts = [ self'.packages.setup-sgi ];
  };
}