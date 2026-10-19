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

## Cherry-pick (2026-10-19, user-directed): archive code merged into the main tree

The archive was not left as dead history: every archive file was compared
against the main tree at procedure level, and what the main tree lacked was
cherry-picked in. Main tree went from 30 modules / 60 files / 2,888 lines to
46 modules / 92 files / 5,453 lines (4,993 pre-header). Nothing in the main
tree was removed or replaced; additions are additive only.

### 16 whole modules ported verbatim from the archive

`M2BST`, `M2RingQueue` → `src/collections/`; `M2Graph`, `M2KMP` → `src/algorithms/`;
`M2Integer`, `M2Interpolation`, `M2Rational`, `M2Stats` → `src/math/`; `M2CRC16` →
`src/security/`; `M2BitOps`, `M2Date` → `src/system/` (new dir); `M2Base64`,
`M2Char`, `M2Hex`, `M2Parse`, `M2Text` → `src/text/`. Verified byte-identical to
the archive files except the one labeled fix below. New dependencies inside the
main tree: `M2Hex`, `M2Parse`, `M2Text` ← `M2Char`; `M2Rational` ← `M2Integer`;
`M2RingQueue` ← `M2Errors`.

- **Labeled porting fix:** `M2RingQueue.mod` imported `ErrInvalidArgument` from
  `M2Errors` but never used it, and main `M2Errors` does not export that
  identifier. The unused import was removed; the body is otherwise verbatim.
- **Known defect, ported verbatim:** `M2Graph` BFS/DFS — the `.def` declares a
  BOOLEAN result, the `.mod` implements them with no return. Do not call
  BFS/DFS until the mismatch is fixed (`examples/cherry_pick_demo.mod`
  exercises the rest of `M2Graph` and skips them).
- **Preserved divergences (ported verbatim, not harmonized):** `M2Char.IsSpace`
  also accepts 18 and 64, unlike `M2Chars.IsSpace`; `M2Text.Length` stops at
  `HIGH(s)` where `M2Strings.Length` stops at `HIGH(s)+1`;
  `M2Interpolation.Trapezoid`/`Bisect` work only on the fixed function
  x^3 - x - 2 (private `FunctionValue`).

### Procedures cherry-picked into 13 overlapping modules (verbatim unless noted)

- `M2Binary`: full streaming API — `Writer`/`Reader` types + `InitWriter`,
  `InitReader`, `PutByte`, `PutU16BE`, `PutU32BE`, `PutBytes`, `GetByte`,
  `GetU16BE`, `GetU32BE`, `GetBytes`, `Position`, `Remaining`.
- `M2CRC32`: `State` type + `Init` + `Final` only (see conflict below).
- `M2CSV`: `ParseRecord`, `WriteField`.
- `M2Complex`: `Divide`, `Scale`.
- `M2Errors`: `ErrorHandler` type + `SetHandler`. `ReportError` now calls the
  handler when one is set, else keeps the existing `StrIO` behavior; `LastError`
  is still recorded in both cases.
- `M2Heap`: `SiftDown` helper + `PushMax`, `PopMax`, `Heapify`, `IsMaxHeap`.
- `M2JSON`: `Length` helper + `UnescapeString`, `IsNumber`.
- `M2Matrix`: flat-array `Multiply`, `Transpose`, `Identity`, `Determinant`,
  `Solve` alongside the `Matrix2` record API.
- `M2Sort`: `ShellSort`, `IsSorted` (explicit-`n` signatures, unlike the main
  sorts which use `HIGH`).
- `M2UTF8`: `Continuation` helper + `Validate`, `CountCodePoints`, `DecodeOne`.

### Adapted, not verbatim (representation or signature forced it)

- `M2List` `Get`/`Set`/`IsEmpty`/`Clear`/`Reverse`: the archive bodies use a
  `ListDesc` (first/last/len) that does not exist in the main tree's
  head-pointer `List`. Rewritten for the main representation, following main
  style. The adapted `Get`/`Set` use a `WHILE` walk: the archive's
  `FOR i:=0 TO index-1` underflows for `index=0` on CARDINAL.
- `M2Stack` `Clear`: the archive version delegates to `M2Vector`; the main
  `M2Stack` is a linked list. Written as node disposal, same body as `Destroy`
  minus the descriptor free (there is none).
- `M2Random` `Generator` type + `Bounded`/`UnitReal`: the archive bodies call
  `Next(state)`, but main `Next()` takes no arguments. The archive `Next`
  algorithm is carried as private `Step(VAR state)`. Archive `Seed` was not
  ported (name/signature conflict with main `Seed`); initialize a `Generator`
  by assigning a non-zero CARDINAL.

### Left in the archive (conflicts, not merged)

- `M2BitSet`: archive uses a heap-allocated `BitSetDesc` model vs main's
  `BITSET`; `Union` has an incompatible signature. Not merged.
- `M2CRC32` length-based `Update`/`Compute`: same names, different signatures
  from main's NUL-terminated versions. Not merged.
- `M2Errors` CARDINAL code model (`ErrNone`, `ErrInvalidArgument`, …): main
  keeps its enum model. Not merged.
- `M2JSON` `EscapeString` fuller variant (escapes `\b \f \n \r \t`): main's
  version (rejects control chars) kept. Not merged.
- `M2Random` `Seed`/`Next` and `M2Sort` `InsertionSort`/`SelectionSort`/
  `HeapSort`: same names, different signatures. Main versions kept.
- `M2Endian`, `M2Search`, `M2Vector`: no unique archive procedures.
  `M2Hash`: no unique archive procedures (main already has extra `Mix32`).
- Verification: every `.def` procedure has a matching `.mod` procedure across
  all 46 modules; verbatim ports check out whitespace-normalized against the
  archive; `tools/check_source.py` reports 46/46 paired.
