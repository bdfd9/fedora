# Allow build scripts to be referenced without being copied into the final image
ARG BASE_IMAGE_NAME="fedora"
ARG BASE_IMAGE_TAG="kinoite"
ARG FEDORA_VERSION="44"
ARG SOURCE_IMAGE="${BASE_IMAGE_NAME}-${BASE_IMAGE_TAG}"
ARG BASE_IMAGE="quay.io/fedora/${SOURCE_IMAGE}"

ARG NVIDIA_FLAVOR="${NVIDIA_FLAVOR:-nvidia-open}"

FROM scratch AS ctx
COPY / /
COPY system_files/ /system_files

FROM ${BASE_IMAGE}:${FEDORA_VERSION} AS base
# FROM ghcr.io/ublue-os/akmods-${NVIDIA_FLAVOR}:main-${FEDORA_VERSION} AS akmods-nvidia

COPY system_files/base /

ARG IMAGE=${IMAGE}

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=tmpfs,dst=/var \
    /ctx/build_files/build.sh 

### LINTING
## Verify final image and contents are correct.
RUN ls -lha && bootc container lint
