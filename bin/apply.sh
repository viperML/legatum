#!/usr/bin/env bash
set -euxo pipefail

DIR=$(cd "$(dirname "$0")"; cd ..; pwd)
MOUNTPOINT="${1:-"/mnt"}"

VERSION_ID=36

ins_cmd () {
    if [ -f $MOUNTPOINT/etc/.$1 ]; then
        echo "reinstall"
    else
        echo "install"
    fi
}

cp -v $MOUNTPOINT/src/stage1/etc/pki/rpm-gpg/* /etc/pki/rpm-gpg/

dnf \
    --installroot=$MOUNTPOINT \
    --releasever $VERSION_ID \
    --assumeyes \
    $(ins_cmd stage1) \
    $MOUNTPOINT/src/pkgs/stage1-*.rpm

dnf \
    --installroot=$MOUNTPOINT \
    --releasever $VERSION_ID \
    --assumeyes \
    update \
    --refresh

dnf \
    --installroot=$MOUNTPOINT \
    --releasever $VERSION_ID \
    --assumeyes \
    install \
    @core

dnf \
    --installroot=$MOUNTPOINT \
    --releasever $VERSION_ID \
    --assumeyes \
    $(ins_cmd stage2) \
    $MOUNTPOINT/src/pkgs/stage2-*.rpm

dnf \
    --installroot=$MOUNTPOINT \
    --releasever $VERSION_ID \
    --assumeyes \
    autoremove

dnf \
    --installroot=$MOUNTPOINT \
    --releasever $VERSION_ID \
    --assumeyes \
    install \
    @kde-desktop-environment
