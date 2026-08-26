{
  perSystem = { pkgs, lib, ... }: {
    packages.jmm = pkgs.stdenv.mkDerivation (finalAttrs: {
      pname = "jmm";
      version = "2.0.0";

      src = fetchGit {
        url = "ssh://git@github.com/Process-ing/feup-comp.git";
        rev = "dafa1023578a669bfd9ab92e9d91b7ddfebf431d";
        shallow = true;
      };

      nativeBuildInputs = [ pkgs.gradle ];

      mitmCache = pkgs.gradle.fetchDeps {
        pkg = finalAttrs.finalPackage;
        data = ./jmm-deps.json;
      };

      gradleBuildTask = "createWebsiteJar";

      installPhase = ''
        mkdir -p $out/share
        cp config.properties $out/share
        cp -r build/install/jmm $out/share/jmm
      '';

      meta.sourceProvenance = with lib.sourceTypes; [
        fromSource
      ];
    });
  };
}