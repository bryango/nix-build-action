#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

### used by nixpkgs-review
git config --global user.email "bryanlais@gmail.com"
git config --global user.name "Bryan Lai"

### clone with github:actions/checkout or this:
# git clone \
#     --filter=blob:none --verbose \
#     --single-branch --branch=master \
#     https://github.com/NixOS/nixpkgs.git

cd nixpkgs || exit

### TODO: use github api instead of manually merging.
### however, one needs to teach nixpkgs-review to look for ofborg reports.

# shellcheck disable=SC2145
nix run .#nixpkgs-review -- pr \
    --build-args="$@" --no-shell --print-result \
    --extra-nixpkgs-config '{ allowInsecurePredicate = x: true; }' --eval local \
    292611

### `--eval local` for insecure packages; should remove for normal packages!
### `$@`: the first argument must exist, will be passed to `--build-args`;
###       the rest of the arguments are passed to `nixpkgs-review`.
