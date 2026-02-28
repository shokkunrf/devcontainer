#!/bin/sh
# References:
#   - https://github.com/shokkunrf/wd

set -eu

echo "Activating feature 'wd'"

VERSION="${VERSION:-latest}"

# Validate version format
if [ "$VERSION" != "latest" ]; then
    case "$VERSION" in
        v[0-9]*)  ;; # e.g., v1.0.0, v1.1.1
        *)
            echo "ERROR: Invalid version format: '$VERSION'"
            echo "Expected 'latest' or a version tag (e.g., 'v1.1.0')."
            exit 1
            ;;
    esac
fi

if [ "$VERSION" = "latest" ]; then
    _url="https://github.com/shokkunrf/wd/releases/latest/download/install.sh"
else
    _url="https://github.com/shokkunrf/wd/releases/download/$VERSION/install.sh"
fi

if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$_url" | sh
elif command -v wget >/dev/null 2>&1; then
    wget -qO- "$_url" | sh
else
    echo "ERROR: curl or wget is required but not found!"
    exit 1
fi
