{ self, ... }:

{
  flake.modules.homeManager.jetbrains-impermanence = self.lib.mkHomePersist {
    directories = [
      ".config/JetBrains"
      ".local/share/JetBrains"
    ];
  };
}