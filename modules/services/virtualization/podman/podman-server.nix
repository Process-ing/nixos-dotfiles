{ self, ... }:

{
  flake.modules.nixos.podman-server = {
    imports = [ self.modules.nixos.podman ];

    # Periodically prune Podman resources (with `podman system prune -f`)
    virtualisation.podman.autoPrune.enable = true;
  };
}
