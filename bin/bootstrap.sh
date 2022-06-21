#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")";cd ..; pwd)
IMAGE="opensuse/tumbleweed"

nix build $DIR
cp $DIR/result/*/* --no-preserve=mode,ownership $DIR/results

sudo docker run \
    --mount type=bind,source=/mnt,target=/mnt \
    --mount type=bind,source=$DIR,target=/mnt/src,readonly \
    "$IMAGE" \
    /usr/bin/env bash -c "/mnt/src/bin/apply.sh /mnt"
