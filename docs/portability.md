<!-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 -->
<!-- Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. -->
<!-- Authored by Ahmad Ali Parr. -->
<!-- Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. -->

# Portability: gm2 13.3.0 findings

On 2026-10-19 `gm2` (GNU Modula-2, version 13.3.0, Ubuntu
`4:13.2.0-7ubuntu1` package line) was installed on this VM and the library
was compiled against it for the first time. This file records what the
real toolchain said. Nothing in the repo was changed to obtain these
results: every fix below was applied to a scratch copy in `/tmp` only.
The repo code is untouched, and the fixes are OFFERED, not installed.

## What actually executed

| Test | Result |
|---|---|
| `tests/unit/test_stack_invariants.mod` | PASS — 26/26 checks, exit 0. One line of output: `M2Lib Error [9]: Stack.Pop`, which is the expected `ErrUnderflow` report from the deliberate Pop-on-empty check. |
| `tests/unit/test_all.mod` | PASS — 5/5 checks, exit 0. |
| `tests/unit/test_core.mod` | BLOCKED — see dialect gaps below. |
| `tests/unit/test_edge_cases.mod` | NOT ATTEMPTED — blocked by the same gaps (it needs `M2Queue`, `M2List`, `M2CRC32`, `M2Binary`, and others below). |

## Dialect gaps: the code was written for a Modula-2 dialect gm2 does not accept

Each gap was confirmed with a minimal probe file in `/tmp`, not inferred
from the library code alone.

### 1. `XOR` is not an operator in gm2

Probe `c := a XOR b;` fails to parse. The library uses `XOR` as a
bitwise operator on `CARDINAL` in 5 files: `M2Hash` (4 uses), `M2Random`
(7), `M2CRC16` (4), `M2CRC32` (4), `M2BitOps` (1).

Fix offered: replace each `a XOR b` with a call to a bitwise-xor helper
(e.g. via `SYSTEM` bit operations or a `BITSET` conversion), or implement
XOR from the target dialect's primitives. There is no one-character fix;
each use needs a real replacement.

### 2. `<<` / `>>` are not operators in gm2

Probe `c := a << 1;` fails with `syntax error, found '<'`. The operators
appear in `M2CRC16` (2 lines) and `M2BitOps` (7 lines).

Fix offered: replace with the dialect's shift primitives (`SYSTEM.SHL` /
`SYSTEM.SHR` or equivalent) per use.

### 3. Based literals `16#...` are not accepted by gm2

Probe `x := 16#CBF43926;` fails to parse at the `#`. Based literals
appear in 15 files (including `M2Hash`, `M2Random`, `M2CRC32`, `M2CRC16`,
`test_core`, `hash_crc_demo`, `binary_demo`).

Fix offered: replace each `16#HHHH` with its decimal value (mechanical;
verified in scratch for `M2CRC32` and `test_core`).

### 4. Procedure-type parameters use `,` in gm2, not `;`

`TYPE ErrorHandler = PROCEDURE (ErrorCode; ARRAY OF CHAR);`
(`src/core/M2Errors.def:12`) fails in every gm2 dialect flag (`-fiso`,
`-fpim2`, `-fpim3`, `-fpim4`). Probe confirms `PROCEDURE (INTEGER,
ARRAY OF CHAR)` compiles and `PROCEDURE (INTEGER; ARRAY OF CHAR)` does
not.

Fix offered: one character — `;` → `,` on that line. Verified in scratch:
`M2Errors` then compiles.

### 5. `NEW` / `DISPOSE` need `ALLOCATE` / `DEALLOCATE` imported

`M2Stack.mod` uses `NEW` / `DISPOSE` without importing `Storage`, and
gm2 reports `ALLOCATE procedure not found for NEW substitution`. The
same gap affects every module that allocates nodes (`M2List`, `M2Queue`,
`M2Vector`, `M2BST`, `M2Graph`, `M2RingQueue`, …).

Fix offered: add `FROM Storage IMPORT ALLOCATE, DEALLOCATE;` to each
allocating module. Verified in scratch: `M2Stack` then compiles, links,
and its 26 invariant checks pass.

### 6. `9C` is not a valid character literal — and `10C` / `13C` mean the wrong codes

`src/text/M2Strings.mod:144,146` (`Trim`) writes `9C`, `10C`, `13C`
intending tab / LF / CR. In Modula-2 a digits-then-`C` literal is
OCTAL: `9C` is invalid (9 is not an octal digit) and does not compile;
`10C` means 8 (backspace), not 10; `13C` means 11 (vertical tab), not
13. So even where it compiles, `Trim` trims the wrong characters.

Fix offered: replace with `CHR(9)`, `CHR(10)`, `CHR(13)`. Verified in
scratch: `M2Strings` then compiles.

## Build notes (gm2 workflow that worked)

- Compile each `.mod` to `.o` with `gm2 -c file.mod -I <all src dirs>`.
- Link with the program `.mod` plus the dependency `.o` files:
  `gm2 -o prog tests/unit/test_x.mod M2A.o M2B.o -I ...`.
  Passing implementation `.mod` files on the link line produces
  duplicate-`main` errors; passing only the program `.mod` leaves the
  dependencies unlinked. The `.mod` + `.o` mix is the form that worked.
- `build.sh`'s `-I` list does not cover `src/filesystem`,
  `src/security`, `src/system`, or `src/time` (already noted in the
  README); the working commands above used all twelve domain dirs.
