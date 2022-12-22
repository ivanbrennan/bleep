{ nixpkgs ? import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/f294325aed382b66c7a188482101b0f336d1d7db.tar.gz";
    sha256 = "1avza1nki4ah7y8kzcya471jqk7k5g3d6vsblkkfxwwahhfbff57";
  })
}:

with nixpkgs { };

haskellPackages.shellFor {
  packages = _: [
    (import ./. { inherit nixpkgs; })
  ];

  buildInputs = [
    cabal-install
    haskellPackages.ghcid
    hlint
  ];
}
