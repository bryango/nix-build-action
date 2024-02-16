#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

git config --global user.email "bryanlais@gmail.com"
git config --global user.name "Bryan Lai"

git clone --filter=blob:none --branch=master --single-branch --verbose https://github.com/NixOS/nixpkgs.git
cd nixpkgs || exit

nix-shell -p nixpkgs-review --run "nixpkgs-review pr --build-args='$*' --no-shell --print-result 289324" || true
