#!/usr/bin/env bash
set -uxo pipefail

DIR=$(cd "$(dirname "$0")";cd ..; pwd)

nix build $DIR -L
mkdir -p $DIR/rpms
cp -v $DIR/result/*/* --no-preserve=mode,ownership $DIR/rpms
