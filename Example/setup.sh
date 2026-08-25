#!/usr/bin/env bash

set -euo pipefail

CALLER_DIR="$(pwd -P)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
LOCAL_XCFRAMEWORKS_PATH="${OPENSWIFTUI_LOCAL_XCFRAMEWORKS_PATH:-}"

print_usage() {
    echo "Usage: OPENSWIFTUI_LOCAL_XCFRAMEWORKS_PATH=<directory> $0"
    echo "       $0 [--local-xcframeworks <directory>]"
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        --local-xcframeworks)
            if [[ $# -lt 2 ]]; then
                echo "error: --local-xcframeworks requires a directory" >&2
                print_usage >&2
                exit 1
            fi
            LOCAL_XCFRAMEWORKS_PATH="$2"
            shift 2
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            echo "error: unknown option: $1" >&2
            print_usage >&2
            exit 1
            ;;
    esac
done

if [[ -n "$LOCAL_XCFRAMEWORKS_PATH" ]]; then
    if [[ "$LOCAL_XCFRAMEWORKS_PATH" != /* ]]; then
        LOCAL_XCFRAMEWORKS_PATH="$CALLER_DIR/$LOCAL_XCFRAMEWORKS_PATH"
    fi
    if [[ ! -d "$LOCAL_XCFRAMEWORKS_PATH" ]]; then
        echo "error: local XCFramework directory does not exist: $LOCAL_XCFRAMEWORKS_PATH" >&2
        exit 1
    fi
    LOCAL_XCFRAMEWORKS_PATH="$(cd "$LOCAL_XCFRAMEWORKS_PATH" && pwd -P)"
    if ! compgen -G "$LOCAL_XCFRAMEWORKS_PATH/*.xcframework" >/dev/null; then
        echo "error: no XCFrameworks found in: $LOCAL_XCFRAMEWORKS_PATH" >&2
        exit 1
    fi
    export OPENSWIFTUI_LOCAL_XCFRAMEWORKS_PATH="$LOCAL_XCFRAMEWORKS_PATH"
    export TUIST_OPENSWIFTUI_LOCAL_XCFRAMEWORKS_PATH="$LOCAL_XCFRAMEWORKS_PATH"
    echo "Using local XCFrameworks from $LOCAL_XCFRAMEWORKS_PATH"
fi

cd "$SCRIPT_DIR"
mise trust "$SCRIPT_DIR/mise.toml"
mise exec -- tuist install
mise exec -- tuist generate --no-open
