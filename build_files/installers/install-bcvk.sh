#!/bin/bash

set -ouex pipefail

curl -sL https://github.com/bootc-dev/bcvk/releases/latest/download/bcvk-x86_64-unknown-linux-gnu.tar.gz | tar -xvzf - -C /usr/bin/
