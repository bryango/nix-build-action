#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

# git log folly-multi-outputs^
nix build --print-build-logs github:NixOS/nixpkgs/staging-next#watchman "$@"
