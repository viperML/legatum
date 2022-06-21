#!/usr/bin/env bash
set -uxo pipefail

DIR=$(cd "$(dirname "$0")";cd ..; pwd)
M=$1

zy="zypper --non-interactive --root $M"

zypper -n refresh
zypper --installroot $M -n install -t pattern enhanced_base
zypper --installroot $m -n install $M/src/results/stage1-*
$zy --gpg-auto-import-keys refresh

