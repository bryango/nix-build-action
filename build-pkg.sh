#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

# https://hydra.nixos.org/jobset/nixpkgs/staging-next
flakeref=github:NixOS/nixpkgs/4a887669bd93a80b40111cd337745d33be35e046

# nix build --print-build-logs --impure --expr 'with import (builtins.getFlake "'"$flakeref"'") {}; mkShell { inputsFrom = [ watchman ]; }' "$@"
# nix why-depends --all --precise ./result "$flakeref"#python3.out || true

nix build --print-build-logs "$flakeref#watchman" "$@"
