#!/bin/bash
# References:
#   - https://bun.com/docs/installation

set -eu

echo "Activating feature 'bun'"

_install_bun() {
    if command -v curl >/dev/null; then
        download_cmd="curl -fsSL https://bun.com/install"
    elif command -v wget >/dev/null; then
        download_cmd="wget -qO- https://bun.com/install"
    else
        echo "ERROR: curl or wget is required but neither was found!"
        return 1
    fi

    # Install as remote user if running as root with non-root remote user
    if [ "$(id -u)" = "0" ] && [ -n "${_REMOTE_USER:-}" ] && [ "$_REMOTE_USER" != "root" ]; then
        su - "$_REMOTE_USER" -c "$download_cmd | bash"
    else
        $download_cmd | bash
    fi
}

_install_bun

echo "Bun installed successfully!"
