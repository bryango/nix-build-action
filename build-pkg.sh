#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

# git log folly-multi-outputs^
nix build --print-build-logs github:bryango/nixpkgs/10b0f19e0d6d4998e4e8e6bea70664ae8923d7cf#watchman "$@"
