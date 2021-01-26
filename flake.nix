{
  inputs = {
    nixpkgs = {
      url = "nixpkgs";
      flake = true;
    };
  };

  description = "Doom WADs, engine included";

  outputs = { self, nixpkgs, ... }: {
    overlay = final: prev: {
      ancient-aliens = final.callPackage ./ancient-aliens { };
    };

    packages.x86_64-linux =
      let pkgs = import nixpkgs { overlays = [ self.overlay ]; };
      in { ancient-aliens = pkgs.ancient-aliens; };

    apps.x86_64_linux =
      let pkgs = import nixpkgs { overlays = [ self.overlay ]; };
      in {
        ancient-aliens = {
          type = "app";
          program = "${pkgs.ancient-aliens}/bin/ancient-aliens";
        };
      };
  };
}
