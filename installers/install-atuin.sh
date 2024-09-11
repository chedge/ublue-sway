#!/bin/bash

set -ouex pipefail

#https://github.com/atuinsh/atuin/releases/download/v18.3.0/atuin-x86_64-unknown-linux-gnu.tar.gz

curl -sL https://github.com/atuinsh/atuin/releases/latest/download/atuin-x86_64-unknown-linux-gnu.tar.gz | tar -xvzf - --strip-components 1 -C /usr/bin atuin-x86_64-unknown-linux-gnu/atuin
