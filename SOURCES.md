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
| `m2lib-complete.tar.gz` | Same tree + 6 empty dirs | Same files as the complete zip, plus empty `benchmarks/`, `docs/api/`, `src/concurrency/`, `src/system/`, `tests/integration/`, `tests/vectors/` (preserved via labelled `.gitkeep` files) |
| `M2LIB_SOURCE_DUMP.txt` (standalone, 46,705 bytes) | 60-file source dump | Byte-identical to `M2LIB_SOURCE_DUMP.txt` inside the complete bundle; it lists exactly the complete generation's 60 `src/` files |

## Why two trees, not one merged `src/`

The two generations are divergent rewrites, not increments:

- First generation (2026-10-18): 34 modules, 68 `src/` files, 3,230 source lines.
- Complete generation (2026-10-19): 30 modules, 60 `src/` files, 2,588 source lines.
- Union: 46 distinct module stems. Overlap: 18 stems — and **every** overlapping file differs
  (0 of 34 shared paths identical), including different APIs for the same module name
  (e.g. `M2Errors`, `M2JSON`, `M2Hash`, `M2Heap`, `M2Endian` moved directories between generations).

Merging them into one `src/` would create duplicate module definitions and break the
pairing checks. So nothing was overwritten:

- Repo root = complete generation, verbatim as supplied.
- `archive/first-generation-2026-10-18/` = first generation, verbatim as supplied,
  except generated caches (`.pytest_cache/`, `__pycache__/`) which were excluded.

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
- Exceptions, kept deliberately unmodified:
  - `archive/first-generation-2026-10-18/` — verbatim historical preservation;
    it keeps its supplied MIT `LICENSE` and has no Opaque headers.
  - `M2LIB_SOURCE_DUMP.txt` — supplied pre-relicense snapshot, kept byte-identical
    to the upload. It therefore lists the 60 `src/` files **without** the headers
    added after it was supplied; it was not regenerated.
  - `.gitignore` / `.gitkeep` files — not source, no headers.
- As supplied, both generations carried an MIT `LICENSE` at their root (complete:
  "M2Lib contributors"; first-gen: "SnapKitty Collective contributors") and no
  per-file headers. The main-tree MIT `LICENSE` has been replaced; the archive's
  MIT `LICENSE` remains.
