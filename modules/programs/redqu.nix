{ stdenv
, lib
, fetchFromGitHub
, babashka
}:

stdenv.mkDerivation {
  pname = "redqu";
  version = "1";

  src = fetchFromGitHub {
    owner = "port19x";
    repo = "redqu";
    rev = "3f41419d3a80a42cbc6d79e868fa9a673aa67044";
    hash = "sha256-o8Nb/EGkVASXiOUZyYwvtn4Wy+oXyYmbLsESiVYFw2U=";
  };

  buildInputs = [ babashka ];

  installPhase = ''
    mkdir -p $out/bin
    chmod +x redqu
    cp -r redqu $out/bin/redqu
  '';

  meta = with lib; {
    description = "A media centric reddit client";
    homepage = "https://github.com/port19x/redqu";
    license = licenses.cc0;
  };
}
