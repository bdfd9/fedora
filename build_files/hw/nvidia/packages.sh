#!/usr/bin/env bash

echo "::group:: ===$(basename "$0")==="

set -ouex pipefail

dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release{,-extras,-mesa}
dnf5 config-manager setopt "terra-mesa".enabled=1 
dnf5 -y copr enable ublue-os/staging 
dnf5 -y install \
    egl-wayland.x86_64 \
    egl-wayland.i686 \
    egl-wayland2.x86_64 \
    egl-wayland2.i686 && \
IMAGE_NAME="kinoite" AKMODNV_PATH="/tmp/rpms/nvidia" MULTILIB=1 /tmp/rpms/nvidia/ublue-os/nvidia-install.sh 
rm -f /usr/share/vulkan/icd.d/nouveau_icd.*.json 
ln -s libnvidia-ml.so.1 /usr/lib64/libnvidia-ml.so
dnf5 config-manager setopt "terra-mesa".enabled=0 
dnf5 -y copr disable ublue-os/staging 


rm -rf /tmp/* || true
rm -rf /var/log/dnf5.log || true
rm -rf /boot/* || true
rm -rf /boot/.* || true

echo "::endgroup::"
