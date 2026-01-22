#!/bin/sh
set -eu

# Usage: install-npm-package.sh <package-name> <version>
# Example: install-npm-package.sh prettier latest

PACKAGE_NAME="$1"
VERSION="${2:-latest}"

echo "Activating feature '$PACKAGE_NAME' Version: $VERSION"

if ! command -v node >/dev/null || ! command -v npm >/dev/null; then
    cat <<EOF
ERROR: Node.js and npm are required but not found!
Please add the Node.js feature to your devcontainer.json:

  "features": {
    "ghcr.io/devcontainers/features/node:1": {}
  }

EOF
    exit 1
fi

PACKAGE="$PACKAGE_NAME"
if [ "$VERSION" != "latest" ]; then
    PACKAGE="$PACKAGE_NAME@$VERSION"
fi

if [ -n "${_REMOTE_USER:-}" ] && [ "$_REMOTE_USER" != "root" ]; then
    su - "$_REMOTE_USER" -c "npm install -g $PACKAGE"
else
    npm install -g $PACKAGE
fi

echo "$PACKAGE_NAME installed successfully!"
