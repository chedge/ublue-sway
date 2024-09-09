#!/bin/bash

set -ouex pipefail

git clone https://github.com/rvaiya/keyd /var/opt/keyd
make -C /var/opt/keyd

# manual install, Makefile install doesn't like installing inside a container
sed 's|@PREFIX@|/usr/local|g' /var/opt/keyd/keyd.service.in > /tmp/keyd.service
install -Dm644 /tmp/keyd.service /var/usrlocal/lib/systemd/system/keyd.service

groupadd keyd
mkdir /var/usrlocal/bin
mkdir -p /var/usrlocal/share/doc/keyd/examples
mkdir -p /var/usrlocal/share/keyd/layouts
mkdir -p /var/usrlocal/share/man/man1

install -m755 /var/opt/keyd/bin/* /var/usrlocal/bin/
install -m644 /var/opt/keyd/docs/*.md /var/usrlocal/share/doc/keyd/
install -Dm644 /var/opt/keyd/examples/* /var/usrlocal/share/doc/keyd/examples/
install -Dm644 /var/opt/keyd/layouts/* /var/usrlocal/share/keyd/layouts
cp -r /var/opt/keyd/data/gnome-* /var/usrlocal/share/keyd
install -Dm644 /var/opt/keyd/data/*.1.gz /var/usrlocal/share/man/man1/
install -Dm644 /var/opt/keyd/data/keyd.compose /var/usrlocal/share/keyd/

systemctl enable keyd
