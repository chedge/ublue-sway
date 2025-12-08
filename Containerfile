## 1. BUILD ARGS
# These allow changing the produced image by passing different build args to adjust
# the source from which your image is built.
# Build args can be provided on the commandline when building locally with:
#   podman build -f Containerfile --build-arg FEDORA_VERSION=40 -t local-image

ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-43}"
ARG IMAGE_NAME="ublue-sway"

FROM scratch AS ctx
COPY /sys_files /sys_files
COPY /build_files /
COPY packages.json /

FROM ghcr.io/ublue-os/akmods:main-${FEDORA_MAJOR_VERSION} AS akmods

FROM quay.io/fedora-ostree-desktops/sway-atomic:${FEDORA_MAJOR_VERSION}

ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-43}"
ARG IMAGE_NAME="ublue-sway"

RUN --mount=type=bind,from=ctx,src=/,dst=/ctx \
    --mount=type=cache,target=/var/cache \
    --mount=type=cache,target=/var/log \
    --mount=type=tmpfs,target=/tmp \
    --mount=type=bind,from=akmods,src=/rpms/ublue-os,dst=/tmp/akmods-rpms \
    --mount=type=bind,from=akmods,src=/kernel-rpms,dst=/tmp/kernel-rpms \
    rm -f /usr/bin/chsh && \
    rm -f /usr/bin/lchsh && \
    /ctx/install.sh && \
    /ctx/initramfs.sh && \
    /ctx/post-install.sh

# bootc lint
RUN ["bootc", "container", "lint"]
