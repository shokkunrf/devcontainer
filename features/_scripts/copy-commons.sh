#!/bin/sh
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FEATURES_DIR="$(dirname "$SCRIPT_DIR")"
COMMON_SCRIPT="$SCRIPT_DIR/_commons/install-npm-package.sh"

# npm パッケージ系の feature 一覧
FEATURES="prettier devcontainer-cli gemini-cli"

for feature in $FEATURES; do
    dest="$FEATURES_DIR/$feature/_install-npm-package.sh"
    cp "$COMMON_SCRIPT" "$dest"
    echo "Copied common script to $feature"
done

echo "Copy complete!"
