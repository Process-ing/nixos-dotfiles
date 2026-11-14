{ self, ... }:

{
  flake.modules.homeManager.jetbrains-impermanence = self.lib.mkHomePersist {
    directories = [
      ".cache/JetBrains"
      ".config/JetBrains"
      ".config/github-copilot"
      ".local/share/JetBrains"
      ".java/.userPrefs"
    ];
  };
}
