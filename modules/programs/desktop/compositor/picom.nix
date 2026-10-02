{
  flake.modules.homeManager.picom = {
    services.picom = {
      enable = true;

      # General settings
      backend = "glx";
      vSync = true;

      # Fading
      fade = true;

      # Opacity
      inactiveOpacity = 0.7;         # Opacity of inactive windows
      
      # Corners
      settings.corner-radius = 15;
    };
  };
}