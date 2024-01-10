#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

flakeref=github:bryango/nix#nix

# nix build --print-build-logs --impure --expr 'with import (builtins.getFlake "'"$flakeref"'") {}; mkShell { inputsFrom = [ watchman ]; }' "$@"
# nix why-depends --all --precise ./result "$flakeref"#python3.out

nix build --print-build-logs "$flakeref" "$@"
nix run "$flakeref" -- flake metadata github:bryango/cheznix --update-input nixpkgs-config "$@" || true
