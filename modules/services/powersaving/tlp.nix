{
  flake.modules.nixos.tlp = {
    services.tlp = {
      enable = true;

      settings = { };
    };
  };
}
