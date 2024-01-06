#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

# https://hydra.nixos.org/jobset/nixpkgs/staging-next
flakeref=github:NixOS/nixpkgs/f3c04dc97a71c8c3e650b4cf1602ec5c26ac1cf1

# nix build --print-build-logs --impure --expr 'with import (builtins.getFlake "'"$flakeref"'") {}; mkShell { inputsFrom = [ watchman ]; }' "$@"
# nix why-depends --all --precise ./result "$flakeref"#python3.out || true

nix build --print-build-logs "$flakeref#watchman" "$@"
