#!/usr/bin/env bash
set -euxo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)"

base=bigz/fedora

if grep /mnt /proc/mounts; then
    umount -R /mnt
    was_mounted=1
else
    was_mounted=0
fi

zfs rollback $base/usr@empty
zfs rollback $base/etc@empty
zfs rollback $base/opt@empty
zfs rollback $base/var@empty
zfs rollback $base/boot@empty

if [[ $was_mounted -eq 1 ]]; then
    exec "$DIR/mount.sh"
fi
