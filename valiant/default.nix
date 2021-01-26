{ stdenv, fetchurl, makeWrapper, unzip, gzdoom }:

stdenv.mkDerivation {
  name = "valiant";
  version = "2015-05-30";

  src = fetchurl {
    url =
      "http://www.gamers.org/pub/idgames/levels/doom2/Ports/megawads/valiant.zip";
    sha256 = "08ci2n7yp80w2r7gpnziwv9ylhsi29cb885d43m8clw45agn8z86";
    name = "valiant.zip";
  };

  buildInputs = [ makeWrapper unzip ];
  dontUnpack = true;

  buildPhase = ''
    mkdir -p $out
    unzip -p $src "Valiant.wad" > $out/valiant.wad
  '';

  installPhase = ''
    makeWrapper \
      ${gzdoom}/bin/gzdoom \
      $out/bin/valiant \
      --add-flags "-file $out/valiant.wad"
  '';

  meta = with stdenv.lib; {
    homepage =
      "https://www.doomworld.com/idgames/levels/doom2/Ports/megawads/valiant";
    longDescription = ''
      Valiant is a MBF megawad for Doom II featuring 32 new maps spanning 5 themed
      episodes. Each map is designed to be played from a pistol start, but some effort
      has been made to support continuous play as well.
    '';
    maintainers = with maintainers; [ djanatyn ];
  };
}
