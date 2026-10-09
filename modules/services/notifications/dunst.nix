{
  flake.modules.homeManager.dunst = {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          # Geometry
          width = "(0, 400)";
          height = "(0, 150)";
          offset = "(15, 74)";
          origin = "top-right";
          vertical_padding = 15;
          horizontal_padding = 20;
          text_icon_padding = 15;
          frame-width = 0;

          # Text
          font = "JetBrainsMono NF 12";
          alignment = "right";

          # Icons
          max_icon_size = 64;
          enable_recursive_icon_lookup = true;
        };
      };
    };
  };
}
