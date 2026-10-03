{
  flake.modules.homeManager.picom = {
    services.picom = {
      enable = true;

      # General settings
      backend = "glx";
      vSync = true;

      # Fading
      fade = true;
      fadeDelta = 3;

      # Opacity
      inactiveOpacity = 0.7;         # Opacity of inactive windows
      
      # Corners
      settings.corner-radius = 15;
      settings.rounded-corners-exclude = [
        "window_type = 'dock'" # Avoid on system bars (like i3bar)
      ];
    };
  };
}