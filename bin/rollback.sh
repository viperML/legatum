#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; cd ..; pwd)
MOUNTPOINT="${1:-"/mnt"}"

set +e
grep $MOUNTPOINT /etc/mtab
was_mounted=$?
set -e

if [ $was_mounted -eq 0 ]; then
    umount -R $MOUNTPOINT
fi

zfs rollback tank/fedora/rootfs@empty

if [ $was_mounted -eq 0 ]; then
    $DIR/bin/mount.sh
fi
