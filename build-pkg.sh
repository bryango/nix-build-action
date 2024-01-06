#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

flakeref=github:NixOS/nixpkgs/e61ae81f8f19d851c3b33e562198dd8f80307f36

nix build --print-build-logs --impure --expr 'with import (builtins.getFlake "'"$flakeref"'") {}; mkShell { inputsFrom = [ watchman ]; }' "$@"
nix why-depends --all --precise ./result "$flakeref"#python3.out || true
