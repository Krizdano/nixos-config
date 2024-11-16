{ pkgs, fetchFromGitHub, ... }:

pkgs.stdenv.mkDerivation {
  name = "nix-helpers";
  verson = "0.1";

  src = fetchFromGitHub {
    owner = "Krizdano";
    repo = "nix-helpers";
    rev = "7b235335b5e05d2c8cd82279dd08679419a8ca83";
    hash = "sha256-AUAIim90DokJIFdaP1Nr1FeXOXSN4P/bIzwJKDMtsoQ=";
  };

  installPhase = ''
    mkdir -p $out/bin/
    cp -r ./src/include $out/bin/include
    cp ./src/nshell.sh $out/bin/shell
    chmod +x $out/bin/shell
    cp ./src/nrun.sh $out/bin/run
    chmod +x $out/bin/run
  '';
}
