#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

# https://hydra.nixos.org/jobset/nixpkgs/staging-next
flakeref=github:NixOS/nixpkgs/8a839514de0e209f779dd9b8347f5855fbb1d77f

# nix build --print-build-logs --impure --expr 'with import (builtins.getFlake "'"$flakeref"'") {}; mkShell { inputsFrom = [ watchman ]; }' "$@"
# nix why-depends --all --precise ./result "$flakeref"#python3.out || true

nix build --print-build-logs "$flakeref#watchman" "$@"
