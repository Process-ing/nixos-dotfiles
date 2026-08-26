{ self, ... }:

{
  perSystem = { pkgs, lib, self', ... }: {
    packages.jmm-website = pkgs.stdenv.mkDerivation (finalAttrs: {
      pname = "jmm-website";
      version = "1.0.4";

      src = pkgs.fetchFromGitHub {
        owner = "limwa";
        repo = "jmm.limwa.pt";
        rev = "1db1829a004d1142280c27eab8bdce3a200225b0";
        sha256 = "sha256-26csNtiFLlGM4RHGc09RYPFTzUlhVKIU6Pa/DTVo+zo=";
      };

      nativeBuildInputs = [ self'.packages.jmm ];

      buildPhase = ''
        # Copy compiler
        cp -r ${self'.packages.jmm}/share compiler
        chmod -R +w compiler 
        
        # Create executable
        mkdir -p compiler/jmm/bin
        cat > compiler/jmm/bin/jmm << EOF
        #!/bin/sh

        eval "java -jar \$(dirname \$0)/../lib/jmm.jar \$*"
        EOF
        chmod +x compiler/jmm/bin/jmm
      '';

      installPhase = ''
        mkdir -p $out/share
        cp -r . $out/share/jmm-website
      '';

      dontPatchShebangs = true;

      meta.sourceProvenance = with lib.sourceTypes; [
        fromSource
        binaryBytecode
      ];
    });
  };

  # Add package
  flake.overlays.default = final: prev: {
    jmm-website = self.packages.${prev.stdenv.hostPlatform.system}.jmm-website;
  };
}