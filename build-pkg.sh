#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

flakeref=github:NixOS/nixpkgs/staging
nix build --print-build-logs --impure --expr "with import ./. {}; mkShell { inputsFrom = [ watchman ]; }" "$@"
nix why-depends --all --precise ./result "$flakeref"#python3.out || true
