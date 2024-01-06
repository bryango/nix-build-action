#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

nix build --print-build-logs github:NixOS/nixpkgs/staging#watchman "$@"
