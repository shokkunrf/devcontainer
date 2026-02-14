#!/bin/sh
# References:
#   - https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md
#   - https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally

set -eu

echo "Activating feature 'node-packages'"

if [ -z "${PACKAGES:-}" ]; then
    echo "No packages specified. Skipping installation."
    exit 0
fi

_install_npm_packages() {
    packages="$*"

    if ! command -v node >/dev/null || ! command -v npm >/dev/null; then
        cat <<EOF
ERROR: Node.js and npm are required but not found!
Please add the Node.js feature to your devcontainer.json:

  "features": {
    "ghcr.io/devcontainers/features/node:1": {}
  }

EOF
        return 1
    fi

    # Not running as root - install normally
    if [ "$(id -u)" != "0" ]; then
        npm install -g $packages
        return 0
    fi

    # No remote user or remote user is root - install as root
    if [ -z "${_REMOTE_USER:-}" ] || [ "$_REMOTE_USER" = "root" ]; then
        npm install -g $packages
        return 0
    fi

    # Running as root with non-root remote user
    npm_prefix="$(npm config get prefix)"
    npm_bin_dir="$(dirname "$(command -v npm)")"

    # User has write permission (e.g., devcontainer images with nvm)
    if su "$_REMOTE_USER" -c "test -w '$npm_prefix/lib/node_modules'" 2>/dev/null; then
        su - "$_REMOTE_USER" -c "PATH=$npm_bin_dir:\$PATH npm install -g $packages"
        return 0
    fi

    # User lacks write permission (e.g., official node:* images)
    # Set up user-owned npm global directory
    user_home="${_REMOTE_USER_HOME:-/home/$_REMOTE_USER}"
    npm_global="$user_home/.npm-global"

    su - "$_REMOTE_USER" -c "mkdir -p '$npm_global'"
    cat > /etc/profile.d/npm-global.sh <<EOF
export NPM_CONFIG_PREFIX="$npm_global"
export PATH="$npm_global/bin:\$PATH"
EOF

    su - "$_REMOTE_USER" -c "PATH=$npm_bin_dir:\$PATH NPM_CONFIG_PREFIX=$npm_global npm install -g $packages"
    export PATH="$npm_global/bin:$PATH"
}

# Convert comma-separated list to space-separated
PACKAGES_LIST=$(echo "$PACKAGES" | tr ',' ' ')

echo "Installing npm packages: $PACKAGES_LIST"

_install_npm_packages $PACKAGES_LIST

echo "npm packages installed successfully!"
