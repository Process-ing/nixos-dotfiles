{ inputs, ... }:

{
  flake.modules.homeManager.zen-browser = {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      profiles = {
        default.presets = {
          catppuccin = {
            enable = true;
            flavor = "Mocha";
            accent = "Blue";
          };
        };
      };
    };
  };
}