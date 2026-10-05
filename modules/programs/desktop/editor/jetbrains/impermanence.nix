{ self, ... }:

{
  flake.modules.homeManager.jetbrains-impermanence = self.lib.mkHomePersist {
    directories = [
      ".cache/JetBrains"
      ".config/JetBrains"
      ".local/share/JetBrains"
      ".java/.userPrefs"
    ];
  };
}