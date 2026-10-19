# M2Lib — Modula-2 Library

Paired Modula-2 definition (`.def`) and implementation (`.mod`) modules organized by domain. Source is authored for a classic Modula-2 module model with GNU Modula-2 runtime assumptions where stated. Exact compiler compatibility is not claimed until compiled with a pinned toolchain.

## Build
Run `./build/build.sh`. The script reports a hard blocker if `gm2` is unavailable. `tools/check_source.py` checks pairing and inventory; it is not a compiler substitute.

## Domains
Core errors/assertions/limits/version; text and UTF-8; collections; sorting/search; arithmetic/complex/matrices/random; CSV/JSON/INI; paths/date; binary endian and streams; CRC-32; framed messages. SHA-256 fails closed rather than returning a fabricated digest until a portable 32-bit arithmetic backend is verified.

## Status
`MODULES.md` tracks implementation separately from compilation/testing. Source files alone are not evidence of compiler success.

## Current source inventory

- Module stems: 30
- Paired source files: 60
- Source lines: 2588
- Pairing: 30 paired; 0 definition-only; 0 implementation-only.
