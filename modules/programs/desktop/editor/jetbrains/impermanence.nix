{ self, ... }:

{
  flake.modules.homeManager.jetbrains-impermanence = self.lib.mkHomePersist {
    directories = [
      ".config/JetBrains"
    ];
  };
}