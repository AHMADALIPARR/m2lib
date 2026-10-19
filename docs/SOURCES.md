<!-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 -->
<!-- Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. -->
<!-- Authored by Ahmad Ali Parr. -->
<!-- Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. -->

# Sources — assistant-added provenance note (not part of the supplied bundles)

This repo was assembled 2026-10-19 from the five files the user uploaded:

| Uploaded file | Contents | Verdict |
|---|---|---|
| `m2lib.zip` | `m2lib/`, 113 entries, dated 2026-10-18 22:50–22:54 | First generation (see `archive/`) |
| `m2lib.tar.gz` | Same tree | Byte-identical to `m2lib.zip` (recursive diff: no differences) |
| `m2lib-complete.zip` | `m2lib/`, 69 files, dated 2026-10-19 15:39 | Main tree (this repo root) |
| `m2lib-complete.tar.gz` | Same tree + 6 empty dirs | Same files as the complete zip, plus empty `benchmarks/`, `docs/api/`, `src/concurrency/`, `src/system/`, `tests/integration/`, `tests/vectors/` (empty placeholders; removed in cleanup — they held no content) |
| `M2LIB_SOURCE_DUMP.txt` (standalone, 46,705 bytes, SHA-256 `e44a72b170b8f679ebdb41bfca35de2f3450156f891c23b31f23dc4c5b15527c`) | 60-file source dump | Byte-identical to the dump inside the complete bundle; it listed exactly the complete generation's 60 `src/` files. Removed in cleanup after verified extraction (see Dump extraction) — no `.txt`, `.zip`, or source-dump files remain in the repo |

## Why two trees, not one merged `src/`

The two generations are divergent rewrites, not increments:

- First generation (2026-10-18): 34 modules, 68 `src/` files, 3,230 source lines.
- Complete generation (2026-10-19): 30 modules, 60 `src/` files, 2,588 source lines.
- Union: 46 distinct module stems. Overlap: 18 stems — and **every** overlapping file differs
  (0 of 34 shared paths identical), including different APIs for the same module name
  (e.g. `M2Errors`, `M2JSON`, `M2Hash`, `M2Heap`, `M2Endian` moved directories between generations).

Merging them into one `src/` would create duplicate module definitions and break the
pairing checks. So the two trees were kept separate:

- Repo root = complete generation (headers/license applied later; see below).
- `archive/first-generation-2026-10-18/` = first generation (headers/license applied
  later; see Cleanup). Generated caches (`.pytest_cache/`, `__pycache__/`) were excluded.

## Status (from the bundles themselves, not re-verified)

- Both generations state compiler verification is BLOCKED: `gm2` was not present in the
  generation environment, and is not present on this VM either. No compile claim is made.

## Re-license (2026-10-19, user-directed)

- The main tree was re-licensed to the SNAPKITTY OPAQUE SOURCE LICENSE v1.0
  (`LicenseRef-Sovereign-Leviathan-SL-AGPL3-001`). Root `LICENSE` is copied
  verbatim from the canonical text (653 lines, diff-identical to
  `mercury-to-metal` / `mathlib5`).
- The Opaque header (SPDX identifier, Copyright (c) 2026 Ahmad Ali Parr,
  "Authored by Ahmad Ali Parr", "Licensed under the SNAPKITTY OPAQUE SOURCE
  LICENSE v1.0. See LICENSE.") was added to every main-tree source and doc
  file: 60 `src/` files, 14 `examples/` demos, 3 `tests/unit/` files,
  2 `tools/` scripts, `build/build.sh`, and 7 Markdown files (87 files total).
  Shebangs preserved. No source content was removed; headers are additive only.
- At this step the archive was left untouched (still MIT, no headers) and the
  dump was kept as the pre-relicense snapshot. Both were changed later in the
  cleanup below.
- As supplied, both generations carried an MIT `LICENSE` at their root (complete:
  "M2Lib contributors"; first-gen: "SnapKitty Collective contributors") and no
  per-file headers. The main-tree MIT `LICENSE` was replaced here; the archive's
  MIT `LICENSE` was replaced in the cleanup below.

## Dump extraction (2026-10-19, user-directed)

- `M2LIB_SOURCE_DUMP.txt` (SHA-256 `e44a72b170b8f679ebdb41bfca35de2f3450156f891c23b31f23dc4c5b15527c`,
  46,705 bytes) was extracted into actual code files, organized into directories,
  by `tools/extract_dump.py`. The extractor reproduced the dump's own directory
  layout: `src/algorithms/`, `src/collections/`, `src/core/`, `src/filesystem/`,
  `src/formats/`, `src/io/`, `src/math/`, `src/network/`, `src/security/`,
  `src/text/`, `src/time/` — 60 files.
- Verification (executed, before removal): 60/60 extracted files matched `src/`
  (ignoring the Opaque headers), and the extraction was byte-identical to the
  supplied pre-header originals. The code in `src/` **is** the dump's contents,
  organized into directories.
- The dump file and the extractor were then removed in the cleanup below, per
  the user's "no source dump" rule. The SHA-256 above and this record are what
  remains of the dump's provenance.

## Cleanup (2026-10-19, user-directed): every file headed, placed, no txt/zip/dump

- Removed: `M2LIB_SOURCE_DUMP.txt` (after the verified extraction above),
  `tools/extract_dump.py` (its input no longer exists), all six `.gitkeep`
  files, and the five empty placeholder dirs they marked
  (`docs/api/`, `src/concurrency/`, `src/system/`, `tests/vectors/`,
  `build/objects/` — `build.sh` recreates `build/objects/`). `benchmarks/` and
  `tests/integration/` keep their `README.md` placeholders.
- Moved: `MODULES.md` → `docs/MODULES.md`, `SOURCES.md` → `docs/SOURCES.md`.
  Root now holds only `LICENSE`, `README.md`, `.gitignore`, and directories.
- Archive re-licensed: the archive tree got the same Opaque `LICENSE` (verbatim,
  653 lines) and the same 4-line header on every source/doc file (68 `src/`
  files, 3 test/tool scripts, `build/build.sh`, `Makefile`, 2 docs). Its two
  `.txt` build records became `.md` with headers, content preserved in fences
  (`build/module-inventory.md`, `build/toolchain.md`). The archive's original
  MIT copyright line ("SnapKitty Collective contributors") is recorded here;
  its source content is otherwise unchanged apart from headers, the `.txt`→`.md`
  conversion, and the `LICENSE` swap.
- `.gitignore` carries the Opaque header as `#` comments.
- Exceptions (headers would corrupt or falsify): the two `LICENSE` files
  (they start with the SPDX identifier line itself) and four archive build
  artifacts — `build/module-inventory.json`, `build/verification-ledger.json`,
  `build/logs/compiler.log`, `build/logs/source-check.log`.
- Result: no `.txt`, `.zip`, or source-dump files remain in the repo.
