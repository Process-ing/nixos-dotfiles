# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, ... }:

{
  flake.modules.nixos.brunol-server = { pkgs, ... }:
  {
    imports = with inputs.self.modules.nixos; [
        temp-de
        temp-display-conf
        temp-shell
        temp-system
        system-base
    ];

    # Configure GRUB as the bootloader
    boot.loader = {
      grub = {
        enable = true;
        device = "nodev";  # This only works in UEFI, change later (aka TODO)
        efiSupport = true;
        useOSProber = true;
      };

      efi.canTouchEfiVariables = true;
    };

    networking.hostName = "brunol-server"; # Define your hostname.

    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Portugal";

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";
    # console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "us";
    #   useXkbConfig = true; # use xkb.options in tty.
    # };
    console.useXkbConfig = true;


    # Define users
    users.users.brunol = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "intl";
    };
    programs.firefox.enable = true;

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
      vim
    ];

    # Configure editor
    environment.variables = {
      EDITOR = "vim";
    };

    # TODO: Move this somewhere else
    programs.git = {
      enable = true;
      config = {
        user = {
          name = "Process-ing";
          email = "42045371+Process-ing@users.noreply.github.com";
        };
        init.defaultBranch = "main";
      };
    };
  };
}
