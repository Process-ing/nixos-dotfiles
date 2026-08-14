{
  flake.modules.homeManager.system-minimal = { config, ... }:
  {
    # In a nutshell, do not touch this
    home.stateVersion = "26.05";
  }
}