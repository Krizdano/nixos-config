{ pkgs, fetchFromGitHub, ... }:

pkgs.stdenv.mkDerivation {
  name = "toki";
  verson = "0.2";

  src = fetchFromGitHub {
    owner = "Krizdano";
    repo = "toki";
    rev = "5648ed9022ace3f0092757e8185bf640e2fc2d67";
    hash = "sha256-LcL3nIXnoo/KbEQ9vPE4r1JyKS716m9N3M2II9GIPDk=";
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
