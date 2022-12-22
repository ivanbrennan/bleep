{ nixpkgs ? import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/04f574a1c0fde90b51bf68198e2297ca4e7cccf4.tar.gz";
    sha256 = "1frf2yspkgy72c5pznjgk8hbla7yyrn78azsf3ypkyb84vml5jnw";
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
