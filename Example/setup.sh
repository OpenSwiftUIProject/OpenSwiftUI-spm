#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

if [[ $# -ne 0 ]]; then
    echo "Usage: $0" >&2
    exit 1
fi

cd "$SCRIPT_DIR"
mise trust "$SCRIPT_DIR/mise.toml"
mise exec -- tuist install
mise exec -- tuist generate --no-open
