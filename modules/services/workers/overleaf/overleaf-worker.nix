{ self, ... }:

{
  flake.modules.nixos.overleaf-worker =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.workers.overleaf;

      toolkitRepo = pkgs.fetchFromGitHub {
        owner = "Process-ing";
        repo = "overleaf-toolkit";
        rev = "d7619b16737f2299beaa421b8c6382dab239c1c4"; # 6.2.2
        sha256 = "sha256-RYLVMJOWqSHzNN267DQ/hg92U/mtmOhGDUJB25pwT0M=";
      };

      volumeBaseFolder = "/mnt/raid1/overleaf";

      folderPermissions = {
        user = "root";
        group = "root";
        mode = "0700";
      };

      mkVariablesEnv = config: ''
        OVERLEAF_APP_NAME=Processing's Overleaf
        ENABLED_LINKED_FILE_TYPES=project_file,project_output_file

        # Enables Thumbnail generation using ImageMagick
        ENABLE_CONVERSIONS=true

        # Disables email confirmation requirement
        EMAIL_CONFIRMATION_DISABLED=true

        # Secret generated at bin/init time
        OVERLEAF_INVITE_TOKEN_SECRET=${config.sops.placeholder."workers/overleaf/invite_token_secret"}

        OVERLEAF_SITE_URL=http://${cfg.domain}
        OVERLEAF_NAV_TITLE=Processing's Overleaf
        # OVERLEAF_HEADER_IMAGE_URL=http://somewhere.com/mylogo.png
        OVERLEAF_ADMIN_EMAIL=${config.constants.serverEmail}

        # OVERLEAF_LEFT_FOOTER='[{"text": "Contact your support team", "url": "mailto:support@example.com"}]'
        # OVERLEAF_RIGHT_FOOTER='[{"text": "Hello, I am on the Right"}]'

        OVERLEAF_EMAIL_FROM_ADDRESS=${config.constants.serverEmail}

        # OVERLEAF_EMAIL_AWS_SES_ACCESS_KEY_ID=
        # OVERLEAF_EMAIL_AWS_SES_SECRET_KEY=

        OVERLEAF_EMAIL_SMTP_HOST=smtp.gmail.com
        OVERLEAF_EMAIL_SMTP_PORT=587
        OVERLEAF_EMAIL_SMTP_SECURE=false
        OVERLEAF_EMAIL_SMTP_USER=${config.constants.serverEmail}
        OVERLEAF_EMAIL_SMTP_PASS=${config.sops.placeholder."workers/overleaf/smtp_pass"}
        OVERLEAF_EMAIL_SMTP_NAME=Server
        # OVERLEAF_EMAIL_SMTP_LOGGER=false
        # OVERLEAF_EMAIL_SMTP_TLS_REJECT_UNAUTH=true
        # OVERLEAF_EMAIL_SMTP_IGNORE_TLS=false
        OVERLEAF_CUSTOM_EMAIL_FOOTER=Processing's Overleaf
        # OVERLEAF_CUSTOM_EMAIL_FOOTER=This system is run by department x
      '';

      mkOverleafRc = ''
        #### Overleaf RC ####

        PROJECT_NAME=overleaf

        # Sharelatex container
        # Uncomment the OVERLEAF_IMAGE_NAME variable to use a user-defined image.
        OVERLEAF_IMAGE_NAME=docker.io/sharelatex/sharelatex
        OVERLEAF_DATA_PATH=${volumeBaseFolder}/data
        SERVER_PRO=false
        OVERLEAF_LISTEN_IP=127.0.0.1
        OVERLEAF_PORT=${toString cfg.port}

        # Sibling Containers
        SIBLING_CONTAINERS_ENABLED=false
        DOCKER_SOCKET_PATH=/var/run/docker.sock

        # Mongo configuration
        MONGO_ENABLED=true
        MONGO_DATA_PATH=${volumeBaseFolder}/mongo
        MONGO_IMAGE=docker.io/mongo
        MONGO_VERSION=8.0

        # Redis configuration
        REDIS_ENABLED=true
        REDIS_DATA_PATH=${volumeBaseFolder}/redis
        REDIS_IMAGE=docker.io/redis:7.4
        REDIS_AOF_PERSISTENCE=true
      '';

      podmanSetup = ''
        # Make script use rootless Podman as Docker
        shopt -s expand_aliases
        alias docker=podman
        # export DOCKER_HOST="unix:///run/user/$(id -u)/podman/podman.sock"
      '';
    in
    {
      options.workers.overleaf = self.lib.mkWebsiteWorkerOptions "Overleaf";

      config = lib.mkIf cfg.enable {

        # Declare secrets
        sops.secrets = {
          "workers/overleaf/smtp_pass" = { };
          "workers/overleaf/invite_token_secret" = { };
        };

        # Create configuration
        sops.templates."workers/overleaf/variables.env" = {
          content = mkVariablesEnv config;
        };

        sops.templates."workers/overleaf/overleaf.rc" = {
          content = mkOverleafRc;
        };

        # Create folders
        systemd.tmpfiles.settings = {
          "10-overleaf" = {
            # Create work directory
            "/var/lib/overleaf".d = folderPermissions;

            # Create storage volumes
            "${volumeBaseFolder}/data".d = folderPermissions;
            "${volumeBaseFolder}/mongo".d = folderPermissions;
            "${volumeBaseFolder}/redis".d = folderPermissions;
          };
        };

        # Create systemd service
        systemd.services.overleaf-toolkit = {
          description = "Overleaf Toolkit Container Orchestrator";
          after = [
            "network.target"
            "podman.target"
            "overleaf-toolkit-setup.target"
          ];
          wantedBy = [ "multi-user.target" ];
          path = [
            pkgs.openssl
            pkgs.bash
            pkgs.podman
            pkgs.docker-compose
          ];
          serviceConfig = {
            Type = "simple";
            TimeoutStopSec = "1200s";
          };

          # Used to configure the toolkit if needed
          preStart = ''
            if [ ! -d ~/toolkit ]; then

              # Copy repo
              cp -r ${toolkitRepo} ~/toolkit
              chmod -R 755 ~/toolkit

              cd ~/toolkit
              bin/init
              
              # Make configuration links
              cd ~/toolkit/config
              mv variables.env variables.env.old
              mv overleaf.rc overleaf.rc.old
              ln -s ${config.sops.templates."workers/overleaf/variables.env".path} variables.env
              ln -s ${config.sops.templates."workers/overleaf/overleaf.rc".path} overleaf.rc
            fi
          '';

          script = ''
            ${podmanSetup}
            cd ~/toolkit
            bin/up
          '';

          preStop = ''
            ${podmanSetup}
            cd ~/toolkit
            bin/stop
          '';
        };

        # Create Nginx host
        services.nginx.virtualHosts.${cfg.domain} = self.lib.mkNginxHost config {
          locations."/" = {
            proxyPass = "http://localhost:${toString cfg.port}";
            proxyWebsockets = true;
          };
        };
      };
    };
}
