{ inputs, ... }:

{
  flake.modules.homeManager.zen-browser = {
    imports = [ inputs.zen-browser.homeModules.beta ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      profiles.default = {
        settings = {
          "zen.welcome-screen.seen" = true;
        };

        search = {
          force = true;
          default = "ddg";
        };

        containersForce = true; # Delete containers not declared here
        containers = {
          "Personal" = {
            color = "blue";
            icon = "fingerprint";
            id = 1;            
          };
          "Uni" = {
            icon = "briefcase";
            id = 2;
          };
        };

        spacesForce = true; # Delete spaces not declared here
        spaces = {
          "Personal" = {
            id = "b473b406-98f3-4960-813d-b321e2592a3e";
            position = 1000;
            icon = "👤";
            container = 1; # Personal
          };
          "Metafor" = {
            id = "e8332184-35bf-4f71-a2b2-ce4cdcdecd1d";
            position = 2000;
            icon = "☦️";
            container = 2; # Uni
          };
          "University" = {
            id = "f943dec4-f1e4-41aa-8095-d1d937e21297";
            position = 3000;
            icon = "🏛️";
            container = 2; # Uni
          };
        };

        pinsForce = true;
        pins = {
          "Personal.Gemini" = {
            id = "92b3aba8-c529-4d17-8f2a-8365131f0ad1";
            url = "https://gemini.google.com";
            position = 101;
            isEssential = true;
            container = 1; # Personal
          };
          "Personal.GitHub" = {
            id = "32f74214-1653-4e42-97cf-34218ec33c44";
            url = "https://github.com";
            position = 102;
            isEssential = true;
            container = 1; # Personal
          };
          "Uni.Gemini" = {
            id = "f18441d1-840c-4ad2-b670-75b7ff9079f5";
            url = "https://gemini.google.com";
            position = 103;
            isEssential = true;
            container = 2; # Uni
          };
          "Uni.GitHub" = {
            id = "be638cf5-29f0-4aa0-816c-4d721f628a9a";
            url = "https://github.com";
            position = 104;
            isEssential = true;
            container = 2; # Uni
          };
        };  

        # Set theme (Catppuccin)
        presets.catppuccin = {
          enable = true;
          flavor = "Mocha";
          accent = "Blue";
        };
      };
    };
  };
}