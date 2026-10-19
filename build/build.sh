#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
python3 tools/check_source.py
if ! command -v gm2 >/dev/null 2>&1; then echo "BLOCKED: gm2 not installed; no compile claim made." >&2; exit 2; fi
gm2 --version
find src -name '*.mod' -print | sort | while IFS= read -r f; do gm2 -c "$f" -I src/core -I src/text -I src/collections -I src/algorithms -I src/math -I src/formats -I src/io -I src/network || exit 1; done
