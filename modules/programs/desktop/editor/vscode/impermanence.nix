{ self, ... }:

{
  flake.modules.homeManager.vscode = self.lib.mkHomePersist {
    directories = [
      ".vscode/extensions"
      ".vscode-shared"
    ];
  };
}