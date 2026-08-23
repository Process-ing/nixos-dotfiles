{
  perSystem = { pkgs, ... }: {
    # This script clones a git project and places it on a certain path, owned
    # by some system user with certain permissions
    # Usage: setup-repo <git-url> <path> <user> <permissions>

    packages.setup-repo = pkgs.writeShellApplication {
      name = "setup-repo";

      runtimeInputs = with pkgs; [ git ];
      
      text = ''
        GIT_URL=$1
        REPO_PATH=$2
        USER=$3
        PERMISSIONS=$4

        # Clone project
        TMP_FOLDER=$(mktemp -d)
        git clone "$GIT_URL" "$TMP_FOLDER"
        sudo mv "$TMP_FOLDER" "$REPO_PATH"
        
        # Setup ownership and permissions
        sudo chown -R "$USER" "$REPO_PATH"
        sudo chgrp -R "$USER" "$REPO_PATH"
        sudo chmod -R "$PERMISSIONS" "$REPO_PATH"
      '';
    };
  };
}