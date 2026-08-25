{
  perSystem = { pkgs, self', ... }: let
    commit = "e86d0ba50e5eab507bf1babcd27d5e9bcbd0d55c";
  in {
    packages.setup-cgra = pkgs.writeShellApplication {
      name = "setup-cgra";

      runtimeInputs = [ self'.packages.setup-repo ];

      text = ''
        # Check if the target folder exists, and finish if true
        if [ -d /srv/cgra ]; then exit 0; fi

        setup-repo 'git@github.com:Process-ing/feup-cgra' ${commit} /srv/cgra nginx 500
      '';
    };

    services.setup-workers.scripts = [ self'.packages.setup-cgra ];
  };
}