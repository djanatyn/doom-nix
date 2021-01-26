{ stdenv, fetchurl, makeWrapper, unzip, gzdoom }:

stdenv.mkDerivation {
  name = "winters-fury";
  version = "2012-06-06";

  src = fetchurl {
    url = "https://www.dropbox.com/s/vopkdkwl8ymnkvo/Winter%27s%20Fury%20v2016.5.zip";
    sha256 = "1cqlw2zklzrypjn9ndfiwcgj3wrlbxqldg040z396p3slnxg0206";
    name = "winters-fury.zip";
  };

  buildInputs = [ makeWrapper unzip ];
  dontUnpack = true;

  buildPhase = ''
    mkdir -p $out
    unzip -p $src "Winter's Fury.wad" > $out/winters-fury.wad
  '';

  installPhase = ''
    makeWrapper \
      ${gzdoom}/bin/gzdoom \
      $out/bin/winters-fury \
      --add-flags "-file $out/winters-fury.wad"
  '';

  meta = with stdenv.lib; {
    homepage = "https://doomwiki.org/wiki/Winter's_Fury";
    longDescription = ''
      This is a 14 map mod for GZDoom, split into 3 parts. The maps have rather
      fast paced action with some scripted sequences and boss fights. If the
      levels seem a bit difficult, there are 5 different skill levels for you to
      choose from. The levels are rather short, but hopefully entertaining, if
      not atmospheric and laggy.


      This mod also features replacements for all the weapons, making some
      faster and others more dangerous. Not only will there be these weapons,
      there is a whole new set of demons that have taken the "Icy" look.
    '';
    maintainers = with maintainers; [ djanatyn ];
  };
}
