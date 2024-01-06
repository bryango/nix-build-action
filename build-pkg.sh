#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

flakeref=github:NixOS/nixpkgs/nixpkgs-unstable
nix build --print-build-logs "$flakeref"#stdenv "$@"
nix why-depends --all --precise "$flakeref"#{stdenv,python3.out} || true
