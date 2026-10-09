{ inputs, self, ... }:

{
  flake.modules.homeManager.zen-browser = { lib, pkgs, ... }: {
    imports = [ inputs.zen-browser.homeModules.beta ];

    programs.zen-browser = {
      enable = true;
      setAsDefaultBrowser = true;

      # Set native messaging hosts for browser-application communication
      nativeMessagingHosts = [ pkgs.firefoxpwa ];

      profiles.default = {
        settings = {
          "zen.tabs.vertical.right-side" = true;
          "zen.view.use-single-toolbar" = false;
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
          "University" = {
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

            pins = {
              "NixOS Search" = {
                id = "e8736f60-8ed7-4d3d-88ea-86eec5e44d13";
                url = "https://search.nixos.org/options?channel=unstable";
                position = 1001;
              };
            };
          };
          "Metafor" = {
            id = "e8332184-35bf-4f71-a2b2-ce4cdcdecd1d";
            position = 2000;
            icon = "☦️";
            container = 2; # University

            pins = {
              "Flang AST" = {
                id = "46376477-bd34-457a-91f3-db32e4126064";
                url = "https://github.com/llvm/llvm-project/blob/release/22.x/flang/include/flang/Parser/parse-tree.h";
                position = 2001;
              };
              "Fortran Grammar" = {
                id = "07af4260-1f9a-4a4e-b26a-45c1df70ab7e";
                url = "https://flang.llvm.org/docs/f2018-grammar.html";
                position = 2002;
              };
              "Notion" = {
                id = "a9bd5b5e-fec6-4be6-9cba-5da623feb861";
                url = "https://app.notion.com";
                position = 2003;
              };
            };
          };
          "University" = {
            id = "f943dec4-f1e4-41aa-8095-d1d937e21297";
            position = 3000;
            icon = "🏛️";
            container = 2; # University

            pins = {
              "Google Classroom" = {
                id = "e7b90776-33c4-4583-a17e-d780761a03f9";
                url = "https://classroom.google.com";
                position = 3001;
              };
              "Google Drive" = {
                id = "f4a49599-aa7c-4f8e-83a1-ce28523eff6e";
                url = "https://drive.google.com";
                position = 3002;
              };
            };
          };
        };

        pinsForce = true;

        # Essentials
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
            position = 201;
            isEssential = true;
            container = 2; # University
          };
          "Uni.GitHub" = {
            id = "be638cf5-29f0-4aa0-816c-4d721f628a9a";
            url = "https://github.com";
            position = 202;
            isEssential = true;
            container = 2; # University
          };
          "Uni.Moodle" = {
            id = "89dbef7c-99cd-431e-aeb9-a812abc90cd1";
            url = "https://moodle2627.up.pt";
            position = 203;
            isEssential = true;
            container = 2; # University
          };
          "Uni.Sigarra" = {
            id = "14e559af-dcce-4357-8b52-a52e4d6d94c8";
            url = "https://sigarra.up.pt/feup";
            position = 204;
            isEssential = true;
            container = 2; # University
          };
        };

        # Set theme (Catppuccin)
        presets.catppuccin = {
          enable = true;
          flavor = "Mocha";
          accent = "Blue";
        };

        # Set placement of extension buttons
        extensionButtons = {
          zen-sidebar-top-buttons = [
            "{446900e4-71c2-419f-a6a7-df9c091e268b}" # Bitwarden
          ];
        };
      };

      policies.ExtensionSettings = lib.mkMerge [
        # Install extensions
        (self.lib.mkExtensionSettings {
          "uBlock0@raymondhill.net" = "ublock-origin";
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
          "87677a2c52b84ad3a151a4a72f5bd3c4@jetpack" = "grammarly-1";
        })

        # Additional settings
        {
          "{446900e4-71c2-419f-a6a7-df9c091e268b}".private_browsing = true; # Allow Bitwarden to run in private windows
        }
      ];
    };
  };
}
