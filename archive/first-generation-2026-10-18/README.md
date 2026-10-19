<!-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 -->
<!-- Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. -->
<!-- Authored by Ahmad Ali Parr. -->
<!-- Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. -->

# M2Lib — Modula-2 Standard Library

A modular Modula-2 library project targeting GNU Modula-2 (`gm2`) where available.
The source tree is organized by domain. Compiler verification is pending because
`gm2` was not present in the generation environment.

## Build and test

Run `./build/build.sh`. The script discovers `gm2`, records its version, compiles
modules in dependency order where supported, and reports unavailable toolchain
components without marking them verified. `./tools/check_source.py` performs
source inventory and structural checks; it is not a compiler substitute.

## Status semantics

The verification ledger distinguishes `IMPLEMENTED`, `COMPILED`, `TESTED`,
`INTEGRATION_VERIFIED`, and `BLOCKED`. Only commands actually executed may
advance verification status.

## Scope

Current implementation batch includes core error reporting and byte utilities,
text operations, collections, sorting/searching, arithmetic, bit operations,
CRC-32, and source checks. More platform-specific areas require compiler/runtime
confirmation before implementation.

## Dialect policy

Use the GNU Modula-2 dialect and the installed compiler's documented intrinsic
and runtime modules. Do not assume ISO, PIM, or Logitech dialect compatibility.
