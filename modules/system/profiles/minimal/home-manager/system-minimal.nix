{ self, ... }:

{
  flake.modules.homeManager.system-minimal = {
    imports = [
      self.modules.generic.constants  # Allow constants usage
    ];

    # In a nutshell, do not touch this
    home.stateVersion = "26.05";
  };
}