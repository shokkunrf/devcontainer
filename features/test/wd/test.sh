#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "wd is installed" wd --version

# Report result
reportResults
