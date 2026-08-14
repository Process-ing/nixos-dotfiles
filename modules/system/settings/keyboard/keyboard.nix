{
  flake.modules.nixos.keyboard = {

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "intl";
    };

    # Copy configuration to console
    console.useXkbConfig = true;
  };
}