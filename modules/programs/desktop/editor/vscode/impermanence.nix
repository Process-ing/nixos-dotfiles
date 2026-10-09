{ self, ... }:

{
  flake.modules.homeManager.vscode = self.lib.mkHomePersist {
    files = [
      ".vscode-shared/sharedStorage/state.vscdb"
    ];

    directories = [
      ".config/Code"
      ".vscode/extensions"
    ];
  };
}
