#!/usr/bin/env bash
set -euxo pipefail

export DIR=$(cd "$(dirname "$0")"; cd ..; pwd)
export MOUNTPOINT="/mnt"
export SRC="$MOUNTPOINT/src"

rm $MOUNTPOINT/etc/resolv.conf

docker run \
    --interactive \
    --tty \
    --rm \
    --mount type=bind,source=$MOUNTPOINT,target=$MOUNTPOINT \
    --mount type=bind,source=$DIR,target=$SRC \
    --cap-add=SYS_ADMIN \
    "fedora" \
    /usr/bin/env bash -c "rpm -Uvh $SRC/pkgs/bubblewrap-*.rpm; bwrap --dev-bind $MOUNTPOINT / --dev /dev --proc /proc --tmpfs /tmp --ro-bind /etc/resolv.conf /etc/resolv.conf --tmpfs /run /usr/bin/env bash"
