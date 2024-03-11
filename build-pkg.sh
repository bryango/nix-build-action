#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

flakeref=github:NixOS/nixpkgs#pkgsCross.raspberryPi.git-branchless

# nix build --print-build-logs --impure --expr 'with import (builtins.getFlake "'"$flakeref"'") {}; mkShell { inputsFrom = [ watchman ]; }' "$@"
# nix why-depends --all --precise ./result "$flakeref"#python3.out

### `$*` is a deliberate hack to make the arguments work with `nixpkgs-review`
# shellcheck disable=SC2048,SC2086
nix build --print-build-logs "$flakeref" $*
# nix run "$flakeref" -- flake metadata github:bryango/cheznix --update-input nixpkgs-config "$@" || true
