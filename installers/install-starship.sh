#!/bin/bash

set -ouex pipefail

curl -sL https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-gnu.tar.gz | tar -xvzf - -C /usr/bin/
