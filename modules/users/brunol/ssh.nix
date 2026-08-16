{ lib, self, ... }:

{
  flake.modules = lib.mkMerge [
    (self.lib.mkSshUser "brunol")
    {
      homeManager.brunol = { config, ... }: {

        # Write known hosts for user
        home.file.".ssh/known_hosts".text = ''
          ${config.constants.publicKey.github}
        '';
      };
    }
  ];
}