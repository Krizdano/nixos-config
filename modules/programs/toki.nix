{ pkgs, fetchFromGitHub, ... }:

pkgs.stdenv.mkDerivation {
  name = "toki";
  verson = "0.2";

  src = fetchFromGitHub {
    owner = "Krizdano";
    repo = "toki";
    rev = "788bdb161239813fabddcbce20e7a923e42eeeb2";
    hash = "sha256-99W3dVvbq3HAtpUdKmsHKVgbVaDn8JYyKA1AQWzArLM=";
  };

  buildPhase = ''
          make withflakesupport
          '' ;

  installPhase = ''
          # ls $out
          mkdir -p $out/bin
          cp build/bin/toki  $out/bin/toki
          '';
}
