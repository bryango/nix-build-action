#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

git config --global user.email "bryanlais@gmail.com"
git config --global user.name "Bryan Lai"

git clone --filter=blob:none --branch=master --single-branch --verbose https://github.com/nixpkgs/nixpkgs.git
cd nixpkgs || exit

nix build .#arrow-cpp "$@" || true
nix build .#python310Packages.autofaiss "$@" || true
