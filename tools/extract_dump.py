#!/usr/bin/env python3
# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Copyright (c) 2026 Ahmad Ali Parr. All rights reserved.
# Authored by Ahmad Ali Parr.
# Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE.

"""Assistant-added: extract M2LIB_SOURCE_DUMP.txt into actual code files.

The dump holds the main tree's 60 src/ files, one section per file:
  ########## <path> ##########
  <blank line>
  <file content>
  <blank line separator, except after the last section>

Usage:
  python3 tools/extract_dump.py [--dump FILE] --out DIR [--verify]

--out receives the dump's own directory layout (e.g. OUT/src/algorithms/...).
--verify additionally checks every extracted file against the matching file
in src/, ignoring the 5-line Opaque header prepended to src/ files at
re-license time. Exits non-zero on any mismatch. Extraction is byte-exact:
the dump's content bytes are written unchanged.
"""
import argparse
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
HEADER_RE = re.compile(r"^########## (\S+) ##########\n", re.M)
OPAQUE_HEADER_LINES = 5  # 4 comment lines + 1 blank line


def parse_dump(text):
    """Return {path: content} for every section in the dump text."""
    matches = list(HEADER_RE.finditer(text))
    if not matches:
        raise ValueError("no dump sections found")
    out = {}
    for i, m in enumerate(matches):
        path = m.group(1)
        if path in out:
            raise ValueError(f"duplicate dump section: {path}")
        # Content starts after the header line + one blank line.
        start = m.end()
        if not text.startswith("\n", start):
            raise ValueError(f"missing blank line after header: {path}")
        start += 1
        if i + 1 < len(matches):
            end = matches[i + 1].start()
            # Sections are separated by one blank line; drop it.
            if not text[end - 1] == "\n" or not text.startswith("\n", end - 1):
                raise ValueError(f"missing separator before: {matches[i+1].group(1)}")
            end -= 1
        else:
            end = len(text)
        out[path] = text[start:end]
    return out


def strip_opaque_header(text):
    """Remove the 5-line Opaque header if present, else return text unchanged."""
    lines = text.splitlines(keepends=True)
    if (len(lines) >= OPAQUE_HEADER_LINES
            and "LicenseRef-Sovereign-Leviathan" in lines[0]
            and lines[4] == "\n"):
        return "".join(lines[OPAQUE_HEADER_LINES:])
    return text


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dump", default=str(ROOT / "M2LIB_SOURCE_DUMP.txt"))
    ap.add_argument("--out", default=str(ROOT / "build" / "dump-extracted"))
    ap.add_argument("--verify", action="store_true",
                    help="compare extracted files against src/ (ignoring Opaque headers)")
    args = ap.parse_args()

    sections = parse_dump(Path(args.dump).read_text())
    out = Path(args.out)
    for rel, content in sections.items():
        dest = out / rel
        dest.parent.mkdir(parents=True, exist_ok=True)
        dest.write_text(content)
    print(f"extracted {len(sections)} files -> {out}")

    if args.verify:
        errors = []
        for rel, content in sections.items():
            src = ROOT / rel
            if not src.is_file():
                errors.append(f"{rel}: missing from src/")
                continue
            if strip_opaque_header(src.read_text()) != content:
                errors.append(f"{rel}: differs from src/ (beyond the Opaque header)")
        if errors:
            print("VERIFY FAILURES:")
            print("\n".join("- " + e for e in errors))
            sys.exit(1)
        print(f"verify: {len(sections)}/{len(sections)} extracted files match src/ (ignoring Opaque headers)")


if __name__ == "__main__":
    main()
