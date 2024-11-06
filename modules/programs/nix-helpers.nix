{ pkgs, fetchFromGitHub, ... }:

pkgs.stdenv.mkDerivation {
  name = "nix-helpers";
  verson = "0.1";

  src = fetchFromGitHub {
    owner = "Krizdano";
    repo = "nix-helpers";
    rev = "c27c5443f7234477bee45bb8d218d0ea1ffc09b2";
    hash = "sha256-pzLYgKqw5MR0jgLgSjHFZ6fsPQJaPfCKdKLZ4pUxc7M=";
  };

  installPhase = ''
    mkdir -p $out/bin/
    cp -r ./src/include $out/bin/include
    cp ./src/nshell.sh $out/bin/nshell
    chmod +x $out/bin/nshell
    cp ./src/nrun.sh $out/bin/nrun
    chmod +x $out/bin/nrun
  '';
}
