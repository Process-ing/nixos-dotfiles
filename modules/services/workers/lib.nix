{ lib, self, ... }:

{
  config.flake.lib = {
    mkWorkerOptions = workerName: {
      enable = lib.mkEnableOption "${workerName} worker";

      port = lib.mkOption {
        type = lib.types.port;
        description = "Port which the worker will use.";
      };
    };

    mkWebsiteWorkerOptions = websiteName: domain: lib.mkMerge [
      (self.lib.mkWorkerOptions "${websiteName} website")

      {
        domain = {
          type = lib.types.str;
          description = "DNS domain of the website";
        };
      }
    ];
  };
}