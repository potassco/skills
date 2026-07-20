#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./common.sh
source "$SCRIPT_DIR/common.sh"

if [[ "$#" -lt 1 ]]; then
    echo "Usage: $0 <encoding.lp> [more.lp ...]" >&2
    exit 2
fi

print_limit_banner "inspect-grounding"
run_clingo_grounder --warn=all --text "$@"