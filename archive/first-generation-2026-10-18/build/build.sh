#!/usr/bin/env bash
# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Copyright (c) 2026 Ahmad Ali Parr. All rights reserved.
# Authored by Ahmad Ali Parr.
# Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE.

set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
mkdir -p build/objects build/logs
{
  echo "M2Lib build record"
  date -u '+UTC %Y-%m-%dT%H:%M:%SZ'
  uname -a
  if command -v gm2 >/dev/null 2>&1; then gm2 --version; else echo 'BLOCKED: gm2 not found'; fi
} > build/toolchain.txt
python3 tools/check_source.py 2>&1 | tee build/logs/source-check.log
CHECK=${PIPESTATUS[0]}
if [ "$CHECK" -ne 0 ]; then exit "$CHECK"; fi
if ! command -v gm2 >/dev/null 2>&1; then
  echo 'BLOCKED: GNU Modula-2 compiler (gm2) is not installed; no compile status will be claimed.' | tee build/logs/compiler.log
  exit 2
fi
# Compile implementation modules in deterministic lexical order. Dependencies are
# expected to be discoverable from source include paths or compiler configuration.
: > build/logs/compiler.log
failed=0
while IFS= read -r -d '' src; do
  echo "== $src ==" | tee -a build/logs/compiler.log
  if gm2 -c -I"$ROOT/src/core" -I"$ROOT/src/text" -I"$ROOT/src/collections" \
      -I"$ROOT/src/algorithms" -I"$ROOT/src/math" -I"$ROOT/src/security" \
      -I"$ROOT/src/system" -I"$ROOT/src/formats" "$src" \
      -o "$ROOT/build/objects/$(basename "${src%.mod}").o" >> build/logs/compiler.log 2>&1; then
    echo "COMPILED $src"
  else
    echo "FAILED $src"
    failed=1
  fi
done < <(find src -type f -name '*.mod' -print0 | sort -z)
if [ "$failed" -ne 0 ]; then echo 'Compiler failures recorded in build/logs/compiler.log'; exit 1; fi
echo 'Compiler batch complete.'
