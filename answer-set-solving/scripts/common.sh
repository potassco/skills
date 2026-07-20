#!/usr/bin/env bash

set -euo pipefail

readonly CLINGO_TIMEOUT_SECONDS="${CLINGO_TIMEOUT_SECONDS:-300}"
readonly CLINGO_MEMORY_LIMIT_MB="${CLINGO_MEMORY_LIMIT_MB:-8192}"
readonly TIMEOUT_KILL_AFTER_SECONDS="${TIMEOUT_KILL_AFTER_SECONDS:-15}"

require_command() {
    command -v "$1" >/dev/null 2>&1 || {
        echo "Missing required command: $1" >&2
        exit 127
    }
}

print_limit_banner() {
    local label="${1:-clingo}"
    echo "[$label] timeout=${CLINGO_TIMEOUT_SECONDS}s memory=${CLINGO_MEMORY_LIMIT_MB}MB" >&2
}

with_limits() {
    local memory_kb=$((CLINGO_MEMORY_LIMIT_MB * 1024))

    if command -v timeout >/dev/null 2>&1; then
        timeout --preserve-status --signal=TERM --kill-after="${TIMEOUT_KILL_AFTER_SECONDS}s" "${CLINGO_TIMEOUT_SECONDS}s" \
            env -u BASH_ENV bash -c 'ulimit -Sv "$1"; shift; exec "$@"' bash "$memory_kb" "$@"
        return
    fi

    env -u BASH_ENV bash -c 'ulimit -Sv "$1"; shift; exec "$@"' bash "$memory_kb" "$@"
}

run_clingo() {
    require_command python3
    with_limits python3 -m clingo "$@"
}

run_python() {
    require_command python3
    with_limits python3 "$@"
}

run_clingo_grounder() {
    require_command python3
    with_limits python3 -m clingo --mode=gringo "$@"
}

run_ngo() {
    require_command python3
    python3 -c 'import ngo' >/dev/null 2>&1 || {
        echo "The Python package ngo is not installed. Install it with: python3 -m pip install ngo" >&2
        exit 127
    }
    with_limits python3 -m ngo "$@"
}