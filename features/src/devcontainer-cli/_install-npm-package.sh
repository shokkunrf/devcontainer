# Usage: Set PACKAGE_NAME and VERSION before sourcing this script
# Example:
#   PACKAGE_NAME="prettier"
#   VERSION="${VERSION:-latest}"
#   . "$SCRIPT_DIR/_install-npm-package.sh"
#
# References:
#   - https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md
#   - https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally

_install_npm_package() {
    echo "Activating feature '$PACKAGE_NAME' Version: $VERSION"

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

    local package="$PACKAGE_NAME"
    if [ "$VERSION" != "latest" ]; then
        package="$PACKAGE_NAME@$VERSION"
    fi

    # Not running as root - install normally
    if [ "$(id -u)" != "0" ]; then
        npm install -g "$package"
        return 0
    fi

    # No remote user or remote user is root - install as root
    if [ -z "${_REMOTE_USER:-}" ] || [ "$_REMOTE_USER" = "root" ]; then
        npm install -g "$package"
        return 0
    fi

    # Running as root with non-root remote user
    local npm_prefix
    npm_prefix="$(npm config get prefix)"

    # User has write permission (e.g., devcontainer images with nvm)
    if su "$_REMOTE_USER" -c "test -w '$npm_prefix/lib/node_modules'" 2>/dev/null; then
        su - "$_REMOTE_USER" -c "npm install -g $package"
        return 0
    fi

    # User lacks write permission (e.g., official node:* images)
    # Set up user-owned npm global directory
    local user_home="${_REMOTE_USER_HOME:-/home/$_REMOTE_USER}"
    local npm_global="$user_home/.npm-global"

    su - "$_REMOTE_USER" -c "mkdir -p '$npm_global'"
    cat > /etc/profile.d/npm-global.sh <<EOF
export NPM_CONFIG_PREFIX="$npm_global"
export PATH="$npm_global/bin:\$PATH"
EOF

    su - "$_REMOTE_USER" -c "NPM_CONFIG_PREFIX='$npm_global' npm install -g $package"
    export PATH="$npm_global/bin:$PATH"
}

_install_npm_package || exit 1
echo "$PACKAGE_NAME installed successfully!"
