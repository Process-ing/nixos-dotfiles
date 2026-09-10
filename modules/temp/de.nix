{
  flake.modules.nixos.temp-de = { pkgs, ... }: {

    # Enable sound.
    # services.pulseaudio.enable = true;
    # OR
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # Install extra packages
    environment.systemPackages = with pkgs; [
      brightnessctl
      vscodium
      pavucontrol
    ];

    # Enable natural scrolling
    services.libinput.touchpad.naturalScrolling = true;
  };
}
