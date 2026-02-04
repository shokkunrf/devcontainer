#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "devcontainer is installed" devcontainer --version
check "devcontainer is upgradable" npm i -g @devcontainers/cli
check "prettier is installed" prettier --version
check "prettier is upgradable" npm i -g prettier

# Report result
reportResults
