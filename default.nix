{ nixpkgs ? import <nixpkgs> }:

let
  pkgs = nixpkgs { };

  filter = path: type:
    # remove .git, *.o, *.~, etc.
    pkgs.lib.cleanSourceFilter path type &&
    # remove .ghc.environment.*
    (builtins.match ".*\\.ghc\\.environment\\..*" path) == null;

  src = ./.;

in
  with pkgs;

  haskellPackages.callCabal2nix
    "bleep"
    (lib.cleanSourceWith { inherit filter src; })
    { }
