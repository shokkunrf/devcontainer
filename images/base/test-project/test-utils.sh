#!/bin/sh

USERNAME=${1:-developer}

if [ -z "$HOME" ]; then
    HOME="/root"
fi

FAILED=""

check() {
    LABEL=$1
    shift
    printf '\n🧪 Testing %s\n' "$LABEL"
    if "$@"; then
        echo "✅  Passed!"
        return 0
    else
        echo "❌ $LABEL check failed."
        FAILED="$FAILED $LABEL"
        return 1
    fi
}

check_version_ge() {
    LABEL=$1
    CURRENT_VERSION=$2
    REQUIRED_VERSION=$3
    printf '\n🧪 Testing %s: '\''%s'\'' is >= '\''%s'\''\n' "$LABEL" "$CURRENT_VERSION" "$REQUIRED_VERSION"
    GREATER_VERSION=$(printf '%s\n%s\n' "$CURRENT_VERSION" "$REQUIRED_VERSION" | sort -V | tail -1)
    if [ "$CURRENT_VERSION" = "$GREATER_VERSION" ]; then
        echo "✅  Passed!"
        return 0
    else
        echo "❌ $LABEL check failed."
        FAILED="$FAILED $LABEL"
        return 1
    fi
}

reportResults() {
    if [ -n "$FAILED" ]; then
        printf '\n💥  Failed tests:%s\n' "$FAILED"
        exit 1
    else
        printf '\n💯  All passed!\n'
        exit 0
    fi
}
