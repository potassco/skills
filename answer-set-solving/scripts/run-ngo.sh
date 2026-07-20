#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./common.sh
source "$SCRIPT_DIR/common.sh"

if [[ "$#" -lt 1 ]]; then
    cat >&2 <<'EOF'
Usage: run-ngo.sh <encoding.lp> [more.lp ...] > optimized.lp

Environment variables:
  NGO_INPUT_PREDICATES    Comma-separated predicates like 'node/1,edge/2' or 'auto'
  NGO_OUTPUT_PREDICATES   Comma-separated predicates like 'selected/2' or 'auto'
  NGO_ENABLE              Space-separated ngo traits, default: 'default'
  NGO_LOG                 ERROR, WARNING, INFO, or DEBUG; default: WARNING
EOF
    exit 2
fi

ngo_log="${NGO_LOG:-WARNING}"
ngo_input_predicates="${NGO_INPUT_PREDICATES:-auto}"
ngo_output_predicates="${NGO_OUTPUT_PREDICATES:-auto}"
read -r -a ngo_enable <<< "${NGO_ENABLE:-default}"

print_limit_banner "run-ngo"
cat "$@" | run_ngo \
    --log "$ngo_log" \
    --input-predicates "$ngo_input_predicates" \
    --output-predicates "$ngo_output_predicates" \
    --enable "${ngo_enable[@]}"