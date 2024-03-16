#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

# ## fetch the necessary license from store
# nix copy --from https://chezbryan.cachix.org --no-check-sigs \
#     /nix/store/xzddkr1n8s5rpbwz0s2n1b2a2wyj010p-license.tar.gz

# flakeref=github:NixOS/nixpkgs#pkgsCross.raspberryPi.git-branchless
flakeref=github:NixOS/nixpkgs/17840d41a7cd2fa044d2205e2c5c38bd673f3b36

# nix build --print-build-logs --impure --expr 'with import (builtins.getFlake "'"$flakeref"'") {}; mkShell { inputsFrom = [ watchman ]; }' "$@"
# nix why-depends --all --precise ./result "$flakeref"#python3.out

### `$*` is a deliberate hack to make the arguments work with `nixpkgs-review`
# shellcheck disable=SC2048,SC2086
nix build --print-build-logs "$flakeref" $*
# nix run "$flakeref" -- flake metadata github:bryango/cheznix --update-input nixpkgs-config "$@" || true
