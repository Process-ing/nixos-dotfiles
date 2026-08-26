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
        mkdir -p compiler
        cp -r ${self'.packages.jmm}/share/jmm compiler/jmm
      '';

      installPhase = ''
        mkdir -p $out/share
        cp -r . $out/share/jmm-website
      '';
    });
  };
}