#!/usr/bin/env bash
set -euxo pipefail

grep /mnt /etc/fstab && umount -R /mnt
zfs rollback tank/suse/rootfs@empty
