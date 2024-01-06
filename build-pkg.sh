#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

# HEAD^ of pr 278643
flakeref=github:NixOS/nixpkgs/10b0f19e0d6d4998e4e8e6bea70664ae8923d7cf

nix build --print-build-logs --impure --expr 'with import (builtins.getFlake "'"$flakeref"'") {}; mkShell { inputsFrom = [ watchman ]; }' "$@"
nix why-depends --all --precise ./result "$flakeref"#python3.out

nix build --print-build-logs "$flakeref#watchman" "$@" || true
