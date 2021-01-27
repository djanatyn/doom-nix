{ stdenv, fetchurl, makeWrapper, unzip, gzdoom }:

stdenv.mkDerivation {
  name = "void-and-rainbow";
  version = "2017-10-26";

  src = fetchurl {
    url = "https://www.dropbox.com/s/zec1gfadjov7bhy/RAINBOW%28G3.2%29.zip";
    sha256 = "sha256-Nt68qWNxrfz3T99sTL3WHTg7SQmhfuHyiRoeztpNwSc=";
    name = "void-and-rainbow.zip";
  };

  buildInputs = [ makeWrapper unzip ];
  dontUnpack = true;

  buildPhase = ''
    mkdir -p $out
    unzip -p $src "RAINBOW(GZD3.2.0).pk3" > $out/void-and-rainbow.pk3
  '';

  installPhase = ''
    makeWrapper \
      ${gzdoom})}/bin/gzdoom \
      $out/bin/void-and-rainbow \
      --add-flags "-file $out/void-and-rainbow.pk3"
  '';

  meta = with stdenv.lib; {
    homepage =
      "https://www.doomworld.com/idgames/levels/doom2/Ports/megawads/void-and-rainbow";
    longDescription = ''
      As once listening to Annihilator and playing one old game, I thought: what
      if I make mountains hovering in space that will shimmer with the colors of
      the rainbow? As a result, having threatened for one year and one month to
      some extent, I realized what I had planned. It was difficult for me alone
      to do everything, and so I called for help TheSkyBug, who made weapons,
      some monsters, and a bunch of different trifles, and also ZZYZX, who made
      a new lighting system. Big thanks to them. Also thanks to ChaingunnerX,
      DOOMGABR, Dagamon, VladGuardian and other people for help of various
      kinds - without you this wad would come out much later.
    '';
    maintainers = with maintainers; [ djanatyn ];
  };
}
