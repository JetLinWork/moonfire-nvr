#!/bin/bash
# This file is part of Moonfire NVR, a security camera network video recorder.
# Copyright (C) 2021 The Moonfire NVR Authors; see AUTHORS and LICENSE.txt.
# SPDX-License-Identifier: GPL-v3.0-or-later WITH GPL-3.0-linking-exception.

# Build the "deploy" target. See Dockerfile.

set -o errexit
set -o pipefail
set -o xtrace

mkdir -p /docker-build-debug/deploy
exec > >(tee -i /docker-build-debug/deploy/output) 2>&1
find /var/cache/apt -ls > /docker-build-debug/deploy/var-cache-apt-before

date
uname -a
export DEBIAN_FRONTEND=noninteractive
time apt-get update
time apt-get install --assume-yes --no-install-recommends \
    libncurses6 \
    libncursesw6 \
    locales \
    sudo \
    sqlite3 \
    tzdata \
    vim-nox
rm -rf /var/lib/apt/lists/*
ln -s moonfire-nvr /usr/local/bin/nvr

find /var/cache/apt -ls > /docker-build-debug/deploy/var-cache-apt-after
date
