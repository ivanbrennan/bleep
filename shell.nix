{ nixpkgs ? import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/e9158eca70ae59e73fae23be5d13d3fa0cfc78b4.tar.gz";
    sha256 = "0cnmvnvin9ixzl98fmlm3g17l6w95gifqfb3rfxs55c0wj2ddy53";
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
