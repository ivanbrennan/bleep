{ nixpkgs ? import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/8746c77a383f5c76153c7a181f3616d273acfa2a.tar.gz";
    sha256 = "1dvhx9hcij3j94yv102f7bhqy73k50sr3lazn28zzj8yg5lbahar";
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
