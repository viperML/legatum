#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; cd ..; pwd)

docker run \
    --interactive \
    --tty \
    --mount type=bind,source=/mnt,target=/mnt \
    --mount type=bind,source=$DIR,target=/mnt/src \
    "opensuse-fat" \
    /bin/bash
