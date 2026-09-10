{
  flake.modules.nixos.temp-nvidia =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      # Allow use of NVIDIA packages as unfree software
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "nvidia-x11"
          "nvidia-settings"
          "nvidia-kernel-modules"
        ];

      # Enable OpenGL
      hardware.graphics = {
        enable = true;
      };

      # Load NVIDIA drivers
      services.xserver.videoDrivers = [
        "modesetting" # Needed for PRIME offloading
        "nvidia"
      ];

      hardware.nvidia = {
        modesetting.enable = true;

        # Only enable if you have graphical corruption issues or application
        # crashes after waking up from sleep.
        powerManagement.enable = false;

        # Enables open source kernel module usage
        open = true;

        # Enable NVIDIA settings menu (with `nvidia-settings`)
        nvidiaSettings = true;

        # Select driver version
        package = config.boot.kernelPackages.nvidiaPackages.stable;

        # Configure NVIDIA Optimus PRIME
        prime = {
          # Allow offloading
          #offload.enable = false;

          sync.enable = true;

          # Refer device bus ID values (see with `lspci`)
          intelBusId = "PCI:0@0:2:0";
          nvidiaBusId = "PCI:1@0:0:0";
        };
      };
    };
}
