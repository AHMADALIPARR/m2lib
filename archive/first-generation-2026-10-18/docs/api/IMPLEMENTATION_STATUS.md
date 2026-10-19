<!-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 -->
<!-- Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. -->
<!-- Authored by Ahmad Ali Parr. -->
<!-- Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. -->

# Implementation Status

This status records source presence separately from compiler verification.

| Domain | Modules currently implemented | Compiler verification |
|---|---|---|
| Core | M2Errors | Blocked: `gm2` unavailable in generation environment |
| Text | M2Char, M2Text, M2Hex, M2Base64, M2UTF8, M2Parse | Blocked |
| Binary I/O | M2Binary | Blocked |
| Collections | M2Vector, M2Stack, M2RingQueue, M2BitSet, M2List, M2BST | Blocked |
| Algorithms | M2Sort, M2Search, M2Heap, M2KMP, M2Graph | Blocked |
| Mathematics | M2Integer, M2Stats, M2Random, M2Rational, M2Complex, M2Matrix, M2Interpolation | Blocked |
| Security/integrity | M2CRC32, M2CRC16, M2Hash | Blocked |
| Systems | M2Endian, M2BitOps, M2Date | Blocked |
| Formats | M2CSV, M2JSON | Blocked |

The source checker verifies module inventory conventions only. It does not prove
syntax, runtime behavior, standards compliance, or cryptographic security. The
build script refuses to claim compiler success if `gm2` is missing.
