#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

# https://hydra.nixos.org/jobset/nixpkgs/staging-next
flakeref=github:NixOS/nixpkgs/887e96e875e933c0a5d203ffc40e202f3d16317e

nix build --print-build-logs --impure --expr 'with import (builtins.getFlake "'"$flakeref"'") {}; mkShell { inputsFrom = [ watchman ]; }' "$@"
nix why-depends --all --precise ./result "$flakeref"#python3.out || true
