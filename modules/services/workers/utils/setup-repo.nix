{
  perSystem = { pkgs, ... }: {
    # This script clones a git project and places it on a certain path, owned
    # by some system user with certain permissions
    # Usage: setup-repo <git-url> <commit> <path> <user> <permissions>

    packages.setup-repo = pkgs.writeShellApplication {
      name = "setup-repo";

      runtimeInputs = with pkgs; [ git ];
      
      text = ''
        GIT_URL=$1
        GIT_SHA=$2
        REPO_PATH=$3
        USER=$4
        PERMISSIONS=$5

        # Clone project
        TMP_FOLDER=$(mktemp -d)
        git -c advice.detachedHead=false clone --depth 1 --revision "$GIT_SHA" "$GIT_URL" "$TMP_FOLDER"
        sudo mv "$TMP_FOLDER" "$REPO_PATH"
        
        # Setup ownership and permissions
        sudo chown -R "$USER" "$REPO_PATH"
        sudo chgrp -R "$USER" "$REPO_PATH"
        sudo chmod -R "$PERMISSIONS" "$REPO_PATH"
      '';
    };
  };
}