{ self, ...}:

{
  flake.modules.nixos.brunol-server = {
    
    # Define users
    imports = with self.modules.nixos; [
      brunol
    ];
  };
}