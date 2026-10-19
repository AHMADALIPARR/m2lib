# Integration tests — assistant-added placeholder

Reserved for end-to-end runs once a `gm2` toolchain exists: build the full
library, run every `tests/unit/*.mod` program, and run the `examples/*.mod`
demos against the compiled library. Until then, the only executable checks
are `tools/check_source.py` (pairing/inventory) and
`tools/check_edge_cases.py` (docs/test consistency).
