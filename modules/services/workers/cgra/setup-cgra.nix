{
  perSystem = { pkgs, ... }: {
    packages.setup-cgra = pkgs.writeShellScriptBin "setup-cgra" ''
      # Check if the target folder exists, and finish if true
      if [ -d /srv/cgra ]; then exit 0; fi

      # Copy project to /srv
      git clone git@github.com:Process-ing/feup-cgra /tmp/cgra
      sudo mv /tmp/cgra /srv/cgra
      
      # Setup ownership and permissions
      sudo chown -R nginx /srv/cgra
      sudo chgrp -R nginx /srv/cgra
      sudo chmod 500 /srv/cgra
    '';
  };
}