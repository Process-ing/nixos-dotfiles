{
  flake.modules.nixos.thermald = {
    # Activate termald (prevents overheating in Intel CPUs)
    services.thermald.enable = true;
  };
}