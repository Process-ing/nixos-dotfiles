{
  flake.modules.nixos.nvidia =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      # Enable OpenGL
      hardware.graphics.enable = true;

      # Load NVIDIA drivers
      services.xserver.videoDrivers = [ "nvidia" ];
     
      hardware.nvidia = {
        modesetting.enable = true;

        # Only enable if you have graphical corruption issues or application
        # crashes after waking up from sleep.
        powerManagement.enable = false;

        # Enables open source kernel module usage
        open = false;

        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;

        # Configure NVIDIA Optimus PRIME
        prime = {
          # Allow offloading
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };

          # Refer device bus ID values (see with `lspci`)
          intelBusId = "PCI:0@0:2:0";
          nvidiaBusId = "PCI:1@0:0:0";
        };
      };
    };
}
