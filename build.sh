#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

git clone https://github.com/bryango/nixpkgs.git
cd nixpkgs || exit

nix-shell -p nixpkgs-review --run "nixpkgs-review pr --print-result 258152"

