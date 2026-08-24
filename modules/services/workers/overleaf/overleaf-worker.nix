{ self, ... }:

{
  flake.modules.nixos.overleaf-worker = { config, lib, ... }: let
    cfg = config.services.overleaf-worker;

    mkVariablesEnv = config: ''
      OVERLEAF_APP_NAME=Processing's Overleaf
      ENABLED_LINKED_FILE_TYPES=project_file,project_output_file

      # Enables Thumbnail generation using ImageMagick
      ENABLE_CONVERSIONS=true

      # Disables email confirmation requirement
      EMAIL_CONFIRMATION_DISABLED=true

      OVERLEAF_SITE_URL=http://${cfg.domain}
      OVERLEAF_NAV_TITLE=Processing's Overleaf
      # OVERLEAF_HEADER_IMAGE_URL=http://somewhere.com/mylogo.png
      OVERLEAF_ADMIN_EMAIL=${config.constants.serverEmail}

      # OVERLEAF_LEFT_FOOTER='[{"text": "Contact your support team", "url": "mailto:example@gmail.com"}]'
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

      OVERLEAF_FILESTORE_MIGRATION_LEVEL=0
    '';

    mkOverleafRc = ''
      #### Overleaf RC ####

      PROJECT_NAME=overleaf

      # Sharelatex container
      # Uncomment the OVERLEAF_IMAGE_NAME variable to use a user-defined image.
      # OVERLEAF_IMAGE_NAME=sharelatex/sharelatex
      OVERLEAF_DATA_PATH=/tmp/overleaf/data
      SERVER_PRO=false
      OVERLEAF_LISTEN_IP=127.0.0.1
      OVERLEAF_PORT=${builtins.toString cfg.port}

      # Mongo configuration
      MONGO_ENABLED=true
      MONGO_DATA_PATH=/tmp/overleaf/mongo
      MONGO_IMAGE=mongo
      MONGO_VERSION=8.0

      # Redis configuration
      REDIS_ENABLED=true
      REDIS_DATA_PATH=/tmp/overleaf/redis
      REDIS_IMAGE=redis:6.2
      REDIS_AOF_PERSISTENCE=true
    '';
  in {
    options.services.overleaf-worker = self.lib.mkWebsiteWorkerOptions "Overleaf";

    config = lib.mkIf cfg.enable {

      # Register overleaf user
      system-user-registry.services = [ "overleaf" ];

      # Declare secrets
      sops.secrets."workers/overleaf/smtp_pass" = {};

      # Create configuration
      sops.templates."workers/overleaf/variables.env" = {
        owner = "overleaf";
        content = mkVariablesEnv config;
        path = "${config.users.users.overleaf.home}/.secrets/variables.env";
      };

      sops.templates."workers/overleaf/overleaf.rc" = {
        owner = "overleaf";
        content = mkOverleafRc;
        path = "${config.users.users.overleaf.home}/.secrets/overleaf.rc";
      };
    };
  };
}