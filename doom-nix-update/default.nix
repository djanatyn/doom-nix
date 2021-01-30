{ zlib, haskellPackages }:

haskellPackages.mkDerivation rec {
  pname = "doom-nix-update";
  version = "0.1.0.0";

  isLibrary = false;
  isExecutable = true;

  executableHaskellDepends = with haskellPackages; [
    cabal-install
    ghcid
    shower

    base
    text
    bytestring
    megaparsec
    parser-combinators

    servant
    servant-client
    servant-client-core

    http-client
    http-media
    http-client-tls

    zlib

    hxt
    hxt-css

    hnix
  ];

  src = builtins.path {
    path = ./.;
    name = pname;
  };

  license = "Unlicense";
}
