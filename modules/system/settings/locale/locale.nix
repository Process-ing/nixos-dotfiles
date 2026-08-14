{
  flake.modules.nixos.locale = {

    # Select internationalisation properties
    i18n.defaultLocale = "en_US.UTF-8";

    # Set time zone
    time.timeZone = "Portugal";
  };
}