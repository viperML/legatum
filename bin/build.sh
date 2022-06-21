#!/usr/bin/env bash
set -uxo pipefail

DIR=$(cd "$(dirname "$0")";cd ..; pwd)

nix build $DIR
cp $DIR/result/*/* --no-preserve=mode,ownership $DIR/results
