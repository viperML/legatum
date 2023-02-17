#!/usr/bin/env bash
set -euxo pipefail

m=/mnt

grep /mnt /etc/mtab && umount -R /mnt

mount -t tmpfs tmpfs $m

base=bigz/fedora

mkdir -p $m/{efi,usr,var,etc,opt,boot}

mount -t zfs $base/usr $m/usr
mount -t zfs $base/var $m/var
mount -t zfs $base/etc $m/etc
mount -t zfs $base/opt $m/opt
mount -t zfs $base/boot $m/boot

mount /dev/disk/by-label/LINUXESP $m/efi

findmnt -R /mnt/
