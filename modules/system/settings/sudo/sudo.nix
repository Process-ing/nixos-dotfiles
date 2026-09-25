{
  flake.modules.nixos.sudo = {
    # Prevent sudo lecture
    security.sudo.extraConfig = ''
      Defaults lecture = never
    '';
  };
}