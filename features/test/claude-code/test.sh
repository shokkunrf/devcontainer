#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "claude is installed" claude --version
check "claude is upgradable" claude upgrade

# Report result
reportResults
