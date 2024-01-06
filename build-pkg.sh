#!/bin/bash
# build home configs

set -x
cd "$(dirname "$0")" || exit

# Merged HEAD of 278643 into cached staging-next
flakeref=github:NixOS/bryango/staging-next-folly

# nix build --print-build-logs --impure --expr 'with import (builtins.getFlake "'"$flakeref"'") {}; mkShell { inputsFrom = [ watchman ]; }' "$@"
# nix why-depends --all --precise ./result "$flakeref"#python3.out

nix build --print-build-logs "$flakeref#watchman" "$@" || true
