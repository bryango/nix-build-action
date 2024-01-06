#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

nix build --print-build-logs github:NixOS/nixpkgs/staging#stdenv "$@"
nix why-depends --all --precise github:NixOS/nixpkgs/staging#{stdenv,python3} "$@" || true
