#!/usr/bin/env bash

echo "::group:: ===$(basename "$0")==="

set -eoux pipefail

echo "=== Building: $IMAGE ==="

modules=()

case "$IMAGE" in
    fedora)
        modules=(
            "base/01-setup-dnf.sh"
            "base/02-install-copr-repos.sh"
            "base/04-packages.sh"
            "hw/base/packages.sh"
            "base/08-firmware.sh"
            "base/10-services.sh"
            # "sign.sh"
            "initramfs.sh"
        )
    ;;
    fedora-nvidia)
        cp -avf "/ctx/system_files/nvidia/." /
        modules=(
            "base/01-setup-dnf.sh"
            "base/02-install-copr-repos.sh"
            "base/04-packages.sh"
            "base/08-firmware.sh"
            "base/10-services.sh"
            "hw/nvidia/packages.sh"
            # "sign.sh"
            "initramfs.sh"
        )
    ;;
    *)
        echo "Unknown image: $IMAGE"
        exit 1
    ;;
esac

for mod in "${modules[@]}"; do
    path="/ctx/build_files/${mod}"
    echo "::group:: === $(basename "$path") ==="
    bash "$path"
    echo "::endgroup::"
done

/ctx/build_files/base/200-cleanup.sh

echo "==> Build complete: $IMAGE"

echo "::endgroup::"
