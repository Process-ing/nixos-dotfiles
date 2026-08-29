{ lib, self, ... }:

let
  mkEnableOption = workerName: lib.mkEnableOption "${workerName} worker";

  mkPortOption = lib.mkOption {
    type = lib.types.port;
    description = "Port which the worker will use.";
  };

  mkDomainOption = lib.mkOption {
    type = lib.types.str;
    description = "DNS domain of the website";
  };
in
{
  config.flake.lib = {
    mkWorkerOptions = workerName: {
      enable = mkEnableOption workerName;
    };

    mkStaticWebsiteWorkerOptions = websiteName: {
      enable = mkEnableOption "${websiteName} website";
      domain = mkDomainOption;
    };

    mkWebsiteWorkerOptions = websiteName: {
      enable = mkEnableOption "${websiteName} website";
      port = mkPortOption;
      domain = mkDomainOption;
    };

    mkNginxHost = config: extraOptions: lib.mkMerge [
      {
        forceSSL = true;
        sslCertificate = config.sops.secrets."nginx/ssl_certificate".path;
        sslCertificateKey = config.sops.secrets."nginx/ssl_certificate_key".path;
      }

      extraOptions
    ];
  };
}