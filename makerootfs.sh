#!/bin/sh
# Usage:
#
#     ./makerootfs.sh <image.yml> <output.img>
#
ARCH=$(uname -m|sed s/aarch64/arm64/|sed s/x86_64/amd64/)
MKROOTFS_TAG=$(linuxkit pkg show-tag pkg/mkrootfs-ext4)-$ARCH

linuxkit build -o - $1 | docker run -v /dev:/dev --privileged -i ${MKROOTFS_TAG} > $2
