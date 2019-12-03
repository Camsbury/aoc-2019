{ nixpkgs ? import <nixpkgs> {
              overlays = [];
            }
}:
let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) haskellPackages;
  project = (import ./default.nix { inherit nixpkgs; });
in
  pkgs.stdenv.mkDerivation {
    name = "shell";
    buildInputs = project.env.nativeBuildInputs ++ [
      haskellPackages.cabal-install
    ];
  }
