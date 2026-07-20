#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./common.sh
source "$SCRIPT_DIR/common.sh"

if [[ "$#" -lt 1 ]]; then
    echo "Usage: $0 <encoding-or-instance.lp> [more.lp ...] [clingo options]" >&2
    exit 2
fi

stats_level="${CLINGO_STATS_LEVEL:-2}"
print_limit_banner "run-clingo"
run_clingo --warn=all "--stats=${stats_level}" "$@"