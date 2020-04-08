{ nixpkgs ? import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/39247f8d04c04b3ee629a1f85aeedd582bf41cac.tar.gz";
    sha256 = "1q7asvk73w7287d2ghgya2hnvn01szh65n8xczk4x2b169c5rfv0";
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
