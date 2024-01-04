#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

git clone --filter=blob:none --branch=folly-multi-outputs --single-branch --verbose https://github.com/bryango/nixpkgs.git
cd nixpkgs || exit

nix build .#watchman "$@"

