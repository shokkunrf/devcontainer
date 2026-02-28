#!/bin/sh
cd "$(dirname "$0")"

. ./test-utils.sh developer

# User check
check "remote-user" test "$(whoami)" = "${USERNAME}"

# Tool checks
check "git" git --version
check "node" node --version

node_version=$(node --version)
check_version_ge "node-requirement" "${node_version}" "v24.0.0"

check "npm" npm --version
check "prettier" prettier --version
check "claude" claude --version
check "gemini" gemini --version
check "wd" wd --version

# Config checks
check "prettierrc" test -f /workspaces/.prettierrc

# Report result
reportResults
