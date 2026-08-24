{
  perSystem = { pkgs, self', ... }: {
    packages.setup-overleaf = pkgs.writeShellApplication {
      name = "setup-overleaf";

      runtimeInputs = [ self'.packages.setup-repo ];

      text = ''
        # Check if the target folder exists, and finish if true
        if [ -d /srv/overleaf ]; then exit 0; fi

        setup-repo 'git@github.com:overleaf/toolkit' /var/lib/overleaf/toolkit 5 400
      '';
    };
  };
}