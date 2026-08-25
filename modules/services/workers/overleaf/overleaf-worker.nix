{ self, ... }:

{
  flake.modules.nixos.overleaf-worker = { config, lib, pkgs, ... }: let
    cfg = config.services.overleaf-worker;

    overleafHome = config.users.users.overleaf.home;

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
      OVERLEAF_DATA_PATH=/tmp/overleaf/data
      SERVER_PRO=false
      OVERLEAF_LISTEN_IP=127.0.0.1
      OVERLEAF_PORT=${toString cfg.port}

      # Sibling Containers
      SIBLING_CONTAINERS_ENABLED=false
      DOCKER_SOCKET_PATH=/var/run/docker.sock

      # Mongo configuration
      MONGO_ENABLED=true
      MONGO_DATA_PATH=/tmp/overleaf/mongo
      MONGO_IMAGE=docker.io/mongo
      MONGO_VERSION=8.0

      # Redis configuration
      REDIS_ENABLED=true
      REDIS_DATA_PATH=/tmp/overleaf/redis
      REDIS_IMAGE=docker.io/redis:7.4
      REDIS_AOF_PERSISTENCE=true
    '';
  in {
    options.services.overleaf-worker = self.lib.mkWebsiteWorkerOptions "Overleaf";

    config = lib.mkIf cfg.enable {

      # Register overleaf user
      system-user-registry.services = [ "overleaf" ];

      # Declare secrets
      sops.secrets = {
        "workers/overleaf/smtp_pass" = {};
        "workers/overleaf/invite_token_secret" = {};
      };

      # Create configuration
      sops.templates."workers/overleaf/variables.env" = {
        owner = "overleaf";
        content = mkVariablesEnv config;
        path = "${overleafHome}/.secrets/variables.env";
      };

      sops.templates."workers/overleaf/overleaf.rc" = {
        owner = "overleaf";
        content = mkOverleafRc;
        path = "${overleafHome}/.secrets/overleaf.rc";
      };

      # Create systemd service
      systemd.services.overleaf-toolkit = {
        description = "Overleaf Toolkit Container Orchestrator";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        path = with pkgs; [
          bash
          podman
          docker-compose
        ];

        script = ''
          if [ ! -d ${overleafHome}/toolkit ]; then
            echo "Warning: setup is missing, terminating..."
            exit 1
          fi

          # Use podman as docker
          shopt -s expand_aliases
          alias docker=podman

          cd ${overleafHome}/toolkit
          bin/up
        '';

        preStop = ''
          shopt -s expand_aliases
          alias docker=podman

          cd ${overleafHome}/toolkit
          bin/down
        '';

        serviceConfig = {
          Type = "simple";
          User = "overleaf";
          Group = "overleaf";
        };
      };

      # Create Nginx host
      services.nginx.virtualHosts.${cfg.domain} = self.lib.mkNginxHost config {
        locations."/" = {
          proxyPass = "http://localhost:${toString cfg.port}";
        };
      };
    };
  };
}