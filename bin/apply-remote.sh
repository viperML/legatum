#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; cd ..; pwd)
MOUNTPOINT="${1:-"/mnt"}"
SRC="$MOUNTPOINT/src"

$DIR/bin/build.sh

docker run \
    --rm \
    --mount type=bind,source=$MOUNTPOINT,target=$MOUNTPOINT \
    --mount type=bind,source=$DIR,target=$SRC \
    --cap-add=SYS_ADMIN \
    "fedora" \
    /usr/bin/env bash -c "/mnt/src/bin/apply.sh"
