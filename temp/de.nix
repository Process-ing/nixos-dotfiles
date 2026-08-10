{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;  
  };
  services.displayManager.defaultSession = "none+i3";


  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  
  # Install extra packages
  environment.systemPackages = with pkgs; [
    pkgs.kitty
    pkgs.brightnessctl
    vscodium
  ];

  # Enable natural scrolling
  services.libinput.touchpad.naturalScrolling = true;
}