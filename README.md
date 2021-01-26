# doom-nix

Play Doom megawads with one Nix command:
```sh
# run in a directory with doom2.wad
$ nix run --impure github:djanatyn/doom-nix#valiant
```

## Dependencies
* your own copy of `doom2.wad`
* `nix` with [flake](https://nixos.wiki/wiki/Flakes) support

## WADs Available
```
❯ nix flake show --impure github:djanatyn/doom-nix
github:djanatyn/doom-nix/4cadceae2608bc0aa7ef4592508557f759ff5c93
├───apps
│   └───x86_64_linux
│       ├───ancient-aliens: app
│       ├───valiant: app
│       └───winters-fury: app
├───overlay: Nixpkgs overlay
└───packages
    └───x86_64-linux
        ├───ancient-aliens: package 'ancient-aliens'
        ├───valiant: package 'valiant'
        └───winters-fury: package 'winters-fury'
```

## How does this work?

Just `makeWrapper` and love:
```
❯ nix shell --impure github:djanatyn/doom-nix#ancient-aliens -c which ancient-aliens
/nix/store/4jjgp5j8zqirql6syxj9s46p8qn9p70b-ancient-aliens/bin/ancient-aliens

❯ cat /nix/store/4jjgp5j8zqirql6syxj9s46p8qn9p70b-ancient-aliens/bin/ancient-aliens
#! /nix/store/dskh7v2h3ly3kdkfk3xmjlqql1zr0hnw-bash-4.4-p23/bin/bash -e
exec "/nix/store/k7b9g1l8x66aii3h7jyll57l2vl8k7xa-zandronum-3.0.1/bin/zandronum"  -file /nix/store/4jjgp5j8zqirql6syxj9s46p8qn9p70b-ancient-aliens/ancient-aliens.wad "$@"
```

## What are next steps?

* Generating nix expressions for megawads using [hnix](https://hackage.haskell.org/package/hnix)
* Allow configuring clients
* Upstream to nixpkgs?
