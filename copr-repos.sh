#!/usr/bin/bash

set -ouex pipefail

# Add Staging repo
dnf5 -y copr enable ublue-os/staging

# Add Bling repo
dnf5 -y copr enable ublue-os/bling

# Patched switcheroo
# Add repo
dnf5 -y copr enable sentry/switcheroo-control_discrete

# Switcheroo patch
dnf5 -y swap \
    --repo=copr:copr.fedorainfracloud.org:sentry:switcheroo-control_discrete \
        switcheroo-control switcheroo-control

dnf5 -y copr remove sentry/switcheroo-control_discrete

# Add Nerd Fonts
dnf5 -y copr enable che/nerd-fonts

#incus, lxc, lxd
if [[ "${FEDORA_MAJOR_VERSION}" -lt "42" ]]; then
    dnf5 -y copr enable ganto/lxc4
fi

#umoci
dnf5 -y copr enable ganto/umoci

#karmab-kcli
dnf5 -y copr enable karmab/kcli

# Fonts
dnf5 -y copr enable atim/ubuntu-fonts

# Kvmfr module
dnf5 -y copr enable hikariknight/looking-glass-kvmfr

# Podman-bootc
dnf5 -y copr enable gmaglione/podman-bootc

# ghostty
dnf5 -y copr enable scottames/ghostty

# Renenable RPMFusion
#sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-{,non}free.repo
#sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-{,non}free-updates.repo
#sed -i '0,/enabled=0/s//enabled=1/' /etc/yum.repos.d/rpmfusion-{,non}free-updates-testing.repo
