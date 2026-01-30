#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "devcontainer is installed" devcontainer --version
check "devcontainer is upgradable" npm i -g @devcontainers/cli

# Report result
reportResults
