{
  perSystem = { pkgs, lib, ... }: {
    packages.jmm = pkgs.stdenv.mkDerivation (finalAttrs: {
      pname = "jmm";
      version = "2.0.0";

      src = fetchGit {
        url = "ssh://git@github.com/Process-ing/feup-comp.git";
        rev = "12905d11df7e09802aa9f6bfa794742f17329e83";
        shallow = true;
      };

      nativeBuildInputs = [ pkgs.gradle ];

      mitmCache = pkgs.gradle.fetchDeps {
        pkg = finalAttrs.finalPackage;
        data = ./jmm-deps.json;
      };

      gradleBuildTask = "installDist";

      installPhase = ''
        mkdir -p $out/{bin,share}
        cp -r build/install/jmm $out/share
        ln -s $out/share/jmm/bin/jmm $out/bin/jmm
      '';

      meta.sourceProvenance = with lib.sourceTypes; [
        fromSource
      ];
    });
  };
}