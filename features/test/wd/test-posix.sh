#!/bin/sh
# POSIX-compliant test script (no bash required)

set -e

FAILED=""

check() {
    LABEL="$1"
    shift
    printf '\n\n'
    printf "🔄 Testing '%s'\n" "$LABEL"
    printf '\033[37m\n'
    if "$@"; then
        printf '\n\n'
        printf "✅  Passed '%s'!\n" "$LABEL"
        return 0
    else
        printf '\n\n'
        printf "❌ %s check failed.\n" "$LABEL" >&2
        FAILED="$FAILED $LABEL"
        return 1
    fi
}

reportResults() {
    printf '\n\n'
    if [ -n "$FAILED" ]; then
        printf "💥  Failed tests:%s\n" "$FAILED" >&2
        exit 1
    else
        printf 'Test Passed!\n'
        exit 0
    fi
}

# Definition specific tests
check "wd is installed" wd --version

# Report result
reportResults
