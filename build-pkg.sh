#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

# ## fetch the necessary license from store
# nix copy --from https://chezbryan.cachix.org --no-check-sigs \
#     /nix/store/xzddkr1n8s5rpbwz0s2n1b2a2wyj010p-license.tar.gz

# flakeref=( .#pulsar )
# flakeref=github:NixOS/nixpkgs#pkgsCross.raspberryPi.git-branchless
# flakeref=( github:bryango/nixpkgs/dev#rust-cbindgen )
# flakeref=( 'github:NixOS/nixpkgs?ref=pull/384706/merge#'{tectonic,texpresso} )
# flakeref=(
#     github:bryango/nixpkgs/tectonic#{tectonic-unwrapped,tectonic,texpresso}
#     github:bryango/nixpkgs/tectonic#tectonic.passthru.tests.{biber-compatibility,workspace,nextonic}
# )
# flakeref=(
#     'github:NixOS/nixpkgs?ref=pull/422680/merge#zed-editor'
# )
flakeref=(
    'github:bryango/nixpkgs?ref=pull/10/merge#grpc'
)

# nix build --print-build-logs --impure --expr 'with import (builtins.getFlake "'"$flakeref"'") {}; mkShell { inputsFrom = [ watchman ]; }' "$@"
# nix why-depends --all --precise ./result "$flakeref"#python3.out

### `$*` is a deliberate hack to make the arguments work with `nixpkgs-review`
# shellcheck disable=SC2048,SC2086
nix build --print-build-logs "${flakeref[@]}" $*
# nix run "$flakeref" -- flake metadata github:bryango/cheznix --update-input nixpkgs-config "$@" || true
