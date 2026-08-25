{
  perSystem = { pkgs, self', ... }: let 
    home = "/var/lib/overleaf";
    
    commit = "1ddb723d467b16141d5d112bec8ab714dde65911";  # 6.2.2

    setup-toolkit = pkgs.writeShellApplication {
      name = "setup-toolkit";

      runtimeInputs = [
        pkgs.openssl 
      ];

      text = ''
        cd ${home}/toolkit
        bin/init
        ln -sf ${home}/.secrets/overleaf.rc ${home}/toolkit/config/overleaf.rc
        ln -sf ${home}/.secrets/variables.env ${home}/toolkit/config/variables.env
      '';
    };
  in {
    packages.setup-overleaf = pkgs.writeShellApplication {
      name = "setup-overleaf";

      runtimeInputs = [
        self'.packages.setup-repo
        setup-toolkit
      ];

      text = ''
        # Check if the target folder exists, and finish if true
        if sudo test -d ${home}/toolkit; then exit 0; fi

        # Clone repository
        setup-repo 'git@github.com:overleaf/toolkit' ${home}/toolkit overleaf 700

        # Configure toolkit
        sudo -u overleaf setup-toolkit
      '';
    };

    services.setup-workers.scripts = [ self'.packages.setup-overleaf ];
  };
}