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
      winters-fury = final.callPackage ./winters-fury { };
    };

    packages.x86_64-linux =
      let pkgs = import nixpkgs { overlays = [ self.overlay ]; };
      in {
        ancient-aliens = pkgs.ancient-aliens;
        winters-fury = pkgs.winters-fury;
      };

    apps.x86_64_linux =
      let pkgs = import nixpkgs { overlays = [ self.overlay ]; };
      in {
        ancient-aliens = {
          type = "app";
          program = "${pkgs.ancient-aliens}/bin/ancient-aliens";
        };

        winters-fury = {
          type = "app";
          program = "${pkgs.winters-fury}/bin/winters-fury";
        };
      };
  };
}
