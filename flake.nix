{
  outputs = { self, nixpkgs }:
    let
      overlay = final: prev: {
        haskellPackages = prev.haskellPackages.override {
          overrides = hself: hsuper: {
            bleep = hsuper.callCabal2nix
              "bleep"
              (final.nix-gitignore.gitignoreSourcePure
                [./.gitignore "flake.nix"]
                ./.
              )
              { };
          };
        };
        bleep =
          final.haskell.lib.buildStrictly
          (final.haskell.lib.justStaticExecutables final.haskellPackages.bleep);
      };

      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [ overlay ];
      };
    in rec {
      overlays.default = overlay;

      packages."x86_64-linux".bleep = pkgs.bleep;
      packages."x86_64-linux".default = packages."x86_64-linux".bleep;

      devShells."x86_64-linux".default =
        pkgs.haskellPackages.shellFor {
          packages = p: [ p.bleep ];
          buildInputs = [
            pkgs.cabal-install
            pkgs.haskellPackages.ghcid
            pkgs.hlint
          ];
          withHoogle = false;
        };
    };
}
