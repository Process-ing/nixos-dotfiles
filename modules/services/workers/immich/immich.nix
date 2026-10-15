{ self, ... }:

{
  flake.modules.nixos.immich-worker = { config, lib, pkgs, ... }: let
    cfg = config.workers.immich;

    immichVersion = "v3";

    volumeFolder = "/mnt/raid1/immich";
    uploadFolder = volumeFolder + "/library";
    databaseFolder = volumeFolder + "/postgres";
    modelCacheFolder = "/var/lib/immich/model-cache";
  in {
    options.workers.immich = self.lib.mkWebsiteWorkerOptions "immich";

    config = lib.mkIf cfg.enable {
      # Register immich
      system-user-registry.services = [ "immich" ];

      # Declare secrets
      sops.secrets."workers/immich/pg_password" = { };

      # Create environment files
      sops.templates."workers/immich/.env" = {
        owner = "immich";
        content = ''
          UPLOAD_LOCATION=${uploadFolder}
          DB_DATA_LOCATION=${databaseFolder}
          TZ=Portugal
          IMMICH_VERSION=${immichVersion}
          DB_PASSWORD=${config.sops.placeholder."workers/immich/pg_password"}
          DB_USERNAME=postgres
          DB_DATABASE_NAME=immich
        '';
      };

      sops.templates."workers/immich/postgres.env" = {
        owner = "immich";
        content = ''
          POSTGRES_PASSWORD=${config.sops.placeholder."workers/immich/pg_password"}
          POSTGRES_USER=postgres
          POSTGRES_DB=immich
          POSTGRES_INITDB_ARGS=--data-checksums
          DB_STORAGE_TYPE=HDD
        '';
      };

      # Create storage volume
      systemd.tmpfiles.settings = let
        folderSettings = {
          user = "immich";
          group = "immich";
          mode = "0700";
        };
      in {
        "10-immich" = {
          ${uploadFolder}.d = folderSettings;
          ${databaseFolder}.d = folderSettings;
          ${modelCacheFolder}.d = folderSettings;
        };
      };

      # Setup containers
      virtualisation.oci-containers.containers = {
        immich_server = {
          image = "ghcr.io/immich-app/immich-server:${immichVersion}";
          volumes = [
            "${uploadFolder}:/data"
            "/etc/localtime:/etc/localtime:ro"
          ];
          environmentFiles = [ config.sops.templates."workers/immich/.env".path ];
          ports = [ "${toString cfg.port}:2283" ];
          dependsOn = [
            "immich_redis"
            "immich_postgres"
          ];
          extraOptions = [
            "--network-alias=immich-server"
            "--network=immich_network"
          ];

          podman.user = "immich";
        };

        immich_machine_learning = {
          image = "ghcr.io/immich-app/immich-machine-learning:${immichVersion}";
          volumes = [
            "${modelCacheFolder}:/cache"
          ];
          environmentFiles = [ config.sops.templates."workers/immich/.env".path ];
          extraOptions = [
            "--network-alias=immich-machine-learning"
            "--network=immich_network"
          ];

          podman.user = "immich";
        };

        immich_redis = {
          image = "docker.io/valkey/valkey:9@sha256:c123e3715db63d06d4ad6964884037aa0d5d4d703939b9929954112889708e1d";
          extraOptions = [
            "--health-cmd=redis-cli ping | grep -q PONG || exit 1"
            "--network-alias=redis"
            "--network=immich_network"
          ];

          podman.user = "immich";
        };

        immich_postgres = {
          image = "ghcr.io/immich-app/postgres:14-vectorchord0.4.3-pgvectors0.2.0@sha256:bcf63357191b76a916ae5eb93464d65c07511da41e3bf7a8416db519b40b1c23";
          environmentFiles = [ config.sops.templates."workers/immich/postgres.env".path ];
          volumes = [
            "${databaseFolder}:/var/lib/postgresql/data"
          ];
          extraOptions = [
            "--shm-size=134217728"
            "--network-alias=database"
            "--network=immich_network"
          ];

          podman.user = "immich";
        };
      };

      # Declare network creation service
      systemd.services."podman-immich_network" = {
        description = "Creates a network for immich";
        wantedBy = [ "multi-user.target" ];
        before = [
          "podman-immich_server.service"
          "podman-immich_machine_learning.service"
          "podman-immich_redis.service"
          "podman-immich_postgres.service"
        ];
        requiredBy = [
          "podman-immich_server.service"
          "podman-immich_machine_learning.service"
          "podman-immich_redis.service"
          "podman-immich_postgres.service"
        ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          User = "immich";
        };

        path = [ pkgs.podman ];
        script = ''
          podman network inspect immich_network || podman network create immich_network
        '';
      };

      # Configure Nginx host
      services.nginx.virtualHosts.${cfg.domain} = self.lib.mkNginxHost config {
        extraConfig = ''
          client_max_body_size 100M;
        '';

        locations."/" = {
          proxyPass = "http://localhost:${toString cfg.port}";
        };
      };
    };
  };
}