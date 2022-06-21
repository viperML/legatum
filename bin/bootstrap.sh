#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")";cd ..; pwd)
IMAGE="opensuse/tumbleweed"

$DIR/bin/build.sh

sudo docker run \
    --mount type=bind,source=/mnt,target=/mnt \
    --mount type=bind,source=$DIR,target=/mnt/src,readonly \
    "$IMAGE" \
    /usr/bin/env bash -c "/mnt/src/bin/apply.sh /mnt"
