#!/bin/sh
# References:
#   - https://cloud.google.com/sdk/docs/install-sdk
#   - https://github.com/GoogleCloudPlatform/cloud-sdk-docker

set -eu

echo "Activating feature 'gcloud'"

# Determine architecture
ARCH="$(uname -m)"
case "$ARCH" in
    x86_64)  ARCH_SUFFIX="x86_64" ;;
    aarch64) ARCH_SUFFIX="arm" ;;
    *)
        echo "ERROR: Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# gcloud needs a system python3 with the sqlite3 stdlib module
# (arm tarball ships no bundled Python; some minimal images ship python3 without libsqlite3).
if ! command -v python3 >/dev/null 2>&1 || ! python3 -c 'import sqlite3' >/dev/null 2>&1; then
    if ! command -v apt-get >/dev/null 2>&1; then
        echo "ERROR: python3 with sqlite3 is required but apt-get is not available"
        exit 1
    fi
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y --no-install-recommends python3 libsqlite3-0
    rm -rf /var/lib/apt/lists/*
fi

INSTALL_DIR="/usr/local"
TARBALL="google-cloud-cli-linux-${ARCH_SUFFIX}.tar.gz"
curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${TARBALL}" | tar -xz -C "$INSTALL_DIR"

# Drop the x86_64-only bundled Python so every arch uses the system one.
rm -rf "${INSTALL_DIR}/google-cloud-sdk/platform/bundledpythonunix"

CLOUDSDK_PYTHON="$(command -v python3)"
export CLOUDSDK_PYTHON

"${INSTALL_DIR}/google-cloud-sdk/install.sh" --quiet --path-update false --command-completion false

ln -s "${INSTALL_DIR}/google-cloud-sdk/bin/gcloud" /usr/local/bin/gcloud

echo "Google Cloud CLI installed successfully!"
