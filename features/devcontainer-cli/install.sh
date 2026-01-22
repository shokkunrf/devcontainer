#!/bin/sh
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
. "$SCRIPT_DIR/_install-npm-package.sh" @devcontainers/cli "${VERSION:-latest}"
devcontainer --version
