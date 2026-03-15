#!/bin/sh
# References:
#   - https://cloud.google.com/sdk/docs/install-sdk

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

INSTALL_DIR="/usr/local"
TARBALL="google-cloud-cli-linux-${ARCH_SUFFIX}.tar.gz"
curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${TARBALL}" | tar -xz -C "$INSTALL_DIR"

"${INSTALL_DIR}/google-cloud-sdk/install.sh" --quiet --path-update false --command-completion false

ln -s "${INSTALL_DIR}/google-cloud-sdk/bin/gcloud" /usr/local/bin/gcloud

echo "Google Cloud CLI installed successfully!"
