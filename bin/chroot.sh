#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; cd ..; pwd)
MOUNTPOINT="${1:-"/mnt"}"
SRC="$MOUNTPOINT/src"


docker run \
    --interactive \
    --tty \
    --rm \
    --mount type=bind,source=$MOUNTPOINT,target=$MOUNTPOINT \
    --mount type=bind,source=$DIR,target=$SRC \
    --cap-add=SYS_ADMIN \
    "fedora" \
    /usr/bin/env bash -c "rpm -Uvh $SRC/rpms/bubblewrap-*.rpm; bwrap --dev-bind $MOUNTPOINT / --dev /dev --proc /proc --tmpfs /tmp --ro-bind /etc/resolv.conf /etc/resolv.conf /usr/bin/env bash"
