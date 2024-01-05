#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

nix build --print-build-logs github:bryango/nixpkgs/folly-multi-outputs#watchman "$@"
