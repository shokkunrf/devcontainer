#!/bin/sh
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PACKAGE_NAME="@google/gemini-cli"
VERSION="${VERSION:-latest}"
. "$SCRIPT_DIR/_install-npm-package.sh"
gemini --version
