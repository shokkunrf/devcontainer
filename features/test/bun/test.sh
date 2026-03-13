#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "bun is installed" bun --version
check "bun is upgradable" bun upgrade

# Report result
reportResults
