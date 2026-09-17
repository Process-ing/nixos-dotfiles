{ self, ... }:

{
  flake.modules.nixos.sops = self.lib.mkPersist {
    files = [ "/var/lib/sops-nix/key.txt" ];
  };
}