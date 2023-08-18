{
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ self.overlays.default ];
      };
    in {
      overlays.default = final: prev: {
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

      packages.${system} = rec {
        bleep = pkgs.bleep;
        default = bleep;
      };

      devShells.${system}.default =
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
