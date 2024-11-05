{ lib
, stdenvNoCC
, makeWrapper
, libnotify
, imagemagick
, swww
, swaybg
, rename
}:
stdenvNoCC.mkDerivation {
  pname = "scripts";
  version = "1.0";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin

    cp chpaper.sh $out/bin/chpaper
    chmod +x $out/bin/chpaper

    cp organize_files.sh $out/bin/sortfiles
    chmod +x $out/bin/sortfiles

    cp clone.sh $out/bin/clone
    chmod +x $out/bin/clone

    # nix helpers
    cp -r nix-helpers/include $out/bin/include
    cp nix-helpers/shell.sh $out/bin/shell
    chmod +x $out/bin/shell
    cp nix-helpers/run.sh $out/bin/run
    chmod +x $out/bin/run

    cp check_for_existing_windows.sh $out/bin/cf
    chmod +x $out/bin/cf

    cp utilities.sh $out/bin/ut
    chmod +x $out/bin/ut

    cp nvim-client.sh $out/bin/nvim-client
    chmod +x $out/bin/nvim-client

    cp volume.sh $out/bin/volume
    chmod +x $out/bin/volume

    cp toggle-screen.sh $out/bin/toggle-screen
    chmod +x $out/bin/toggle-screen

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/chpaper --prefix PATH : ${lib.makeBinPath [imagemagick libnotify swww swaybg]}
    wrapProgram $out/bin/sortfiles --prefix PATH : ${lib.makeBinPath [ rename ]}
  '';
}
