#!/usr/bin/env bash
set -euxo pipefail

m=/mnt

grep /mnt /etc/mtab && umount -R /mnt

mount -t zfs -o zfsutil tank/suse/rootfs $m

mkdir -p $m/boot/efi
mount /dev/disk/by-label/LINUXESP $m/boot/efi
