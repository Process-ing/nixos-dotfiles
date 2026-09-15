{
  flake.modules.nixos.touchpad = {
    # Enable natural scrolling
    services.libinput.touchpad.naturalScrolling = true;
  };
}