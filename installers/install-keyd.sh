#!/bin/bash

set -ouex pipefail

git clone https://github.com/rvaiya/keyd /tmp/keyd
make -C /tmp/keyd

# manual install, Makefile install doesn't like installing inside a container
sed 's|@PREFIX@|/usr|g' /tmp/keyd/keyd.service.in > /tmp/keyd.service
install -Dm644 /tmp/keyd.service /usr/lib/systemd/system/keyd.service

groupadd keyd

mkdir -p /usr/share/doc/keyd/examples
mkdir -p /usr/share/keyd/layouts

install -m755 /tmp/keyd/bin/* /usr/bin/
install -m644 /tmp/keyd/docs/*.md /usr/share/doc/keyd/
install -Dm644 /tmp/keyd/examples/* /usr/share/doc/keyd/examples/
install -Dm644 /tmp/keyd/layouts/* /usr/share/keyd/layouts
cp -r /tmp/keyd/data/gnome-* /usr/share/keyd
install -Dm644 /tmp/keyd/data/*.1.gz /usr/share/man/man1/
install -Dm644 /tmp/keyd/data/keyd.compose /usr/share/keyd/

systemctl enable keyd
