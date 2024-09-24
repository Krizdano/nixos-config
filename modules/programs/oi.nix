{
  rustPlatform,
  fetchFromGitHub
}:

rustPlatform.buildRustPackage {
  pname = "oi";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "PureArtistry";
    repo = "oi";
    rev = "f456a0ba1e1a0457d690c70791dc8c29a02cac2e";
    sha256 = "sha256-BqCtzGBfyV5o8TquFtIMqwA4DrBtnyG4ZSWqHxOexpg=";
  };

  cargoHash = "sha256-v2TUyc35ED8lPIS8ZrvvPwjKNhIpAi0sDw9ymJ5nJp4=";

  meta = {
    description = "trivia in commandline";
    homepage = "https://github.com/PurArtistry/oi";
  };
}
