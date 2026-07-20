#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=./common.sh
source "$SCRIPT_DIR/common.sh"

if [[ "$#" -lt 1 ]]; then
    echo "Usage: $0 <encoding.lp> [more.lp ...]" >&2
    exit 2
fi

print_limit_banner "syntax-check"
run_python - "$@" <<'PY'
import sys

import clingo.ast


messages = []


def logger(code, message):
    text = str(message)
    messages.append(text)
    print(text, file=sys.stderr)


try:
    clingo.ast.parse_files(sys.argv[1:], lambda _ast: None, logger=logger)
except RuntimeError as exc:
    if not messages:
        print(str(exc), file=sys.stderr)
    raise SystemExit(1)

if any("error" in message.lower() for message in messages):
    raise SystemExit(1)
PY
echo "Syntax check passed." >&2