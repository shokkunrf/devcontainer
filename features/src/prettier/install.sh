#!/bin/sh
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PACKAGE_NAME="prettier"
VERSION="${VERSION:-latest}"
. "$SCRIPT_DIR/_install-npm-package.sh"
prettier --version
