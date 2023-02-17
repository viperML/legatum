#!/usr/bin/env bash
set -euxo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)"
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")"; cd ..; pwd)"

M=/mnt

if ! grep $M /proc/mounts; then
    exit 1
fi


read -p "Shell? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker run \
        --mount type=bind,source=$M,target=$M \
        --mount type=bind,source="$SRC",target=$M/src,readonly \
        --cap-add=SYS_ADMIN \
        -it \
        fedora:37 \
        bash

    exit 0
fi


read -p "Bootstrap? [y/N] " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker run \
        --mount type=bind,source=$M,target=$M \
        --mount type=bind,source="$SRC",target=$M/src,readonly \
        --cap-add=SYS_ADMIN \
        fedora:37 \
        dnf --installroot=/mnt --releasever=37 -y install @core
fi
