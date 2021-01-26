{ stdenv, fetchurl, makeWrapper, zandronum }:

stdenv.mkDerivation {
  name = "ancient-aliens";
  version = "2016-07-17";

  src = fetchurl {
    url =
      "http://www.gamers.org/pub/idgames/levels/doom2/Ports/megawads/aaliens.zip";
    sha256 = "18wh7n9g5mw4v65cknfynv68cy8d94ks9di81s7a5yxdmqaynxvz";
  };

  buildInputs = [ makeWrapper ];
  dontUnpack = true;

  buildPhase = ''
    install -Dm755 $src $out/ancient-aliens.wad
  '';

  installPhase = ''
    makeWrapper \
      ${zandronum}/bin/zandronum \
      $out/bin/ancient-aliens \
      --add-flags "-file $out/ancient-aliens.wad"
  '';

  meta = with stdenv.lib; {
    homepage = "https://www.doomworld.com/idgames/levels/doom2/Ports/megawads/aaliens";
    longDescription = ''
        Ancient Aliens is a megawad featuring 32 colorful, action-packed maps for Boom compatible ports.
        Go on a journey to discover the truth about the enigmatic origins of human civilization...
        I'm not saying it was aliens, but... the truth is out there.
    '';
    maintainers = with maintainers; [ djanatyn ];
  };
}
