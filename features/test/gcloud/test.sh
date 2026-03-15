#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "gcloud is installed" gcloud --version
check "gcloud is upgradable" gcloud components update --quiet

# Report result
reportResults
