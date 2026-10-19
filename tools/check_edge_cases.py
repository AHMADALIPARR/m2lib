#!/usr/bin/env python3
"""Assistant-added consistency checks (structural only, not a compiler test).

Checks:
  1. Every demo / test .mod file's MODULE name matches its filename stem.
  2. Every HALT(n) in tests/unit/test_edge_cases.mod has a matching row
     in docs/edge-cases.md (row starts with "| <n> |").
  3. No TODO / FIXME / TBD / UNIMPLEMENTED markers in the new files.
"""
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
errors = []

for p in sorted(list((ROOT / "examples").glob("*.mod")) + [(ROOT / "tests/unit/test_edge_cases.mod")]):
    text = p.read_text(errors="replace")
    m = re.search(r"^\s*MODULE\s+(\w+)\s*;", text, re.M | re.I)
    if not m:
        errors.append(f"{p.relative_to(ROOT)}: missing MODULE header")
    elif m.group(1) != p.stem:
        errors.append(f"{p.relative_to(ROOT)}: MODULE {m.group(1)} != filename {p.stem}")
    if re.search(r"\b(TODO|FIXME|TBD|UNIMPLEMENTED)\b", text, re.I):
        errors.append(f"{p.relative_to(ROOT)}: placeholder marker")

edge = ROOT / "tests/unit/test_edge_cases.mod"
doc = ROOT / "docs/edge-cases.md"
halts = sorted({int(n) for n in re.findall(r"HALT\((\d+)\)", edge.read_text())})
rows = set()
for line in doc.read_text().splitlines():
    m = re.match(r"\|\s*(\d+)\s*\|", line)
    if m:
        rows.add(int(m.group(1)))
missing = [n for n in halts if n not in rows]
if missing:
    errors.append(f"docs/edge-cases.md missing rows for HALT codes: {missing}")
extra = sorted(rows - set(halts))
if extra:
    errors.append(f"docs/edge-cases.md has rows with no test: {extra}")

print(f"edge-case HALT checks: {len(halts)} (docs rows: {len(rows)})")
if errors:
    print("EDGE-CASE CHECK FAILURES:")
    print("\n".join("- " + e for e in errors))
    sys.exit(1)
print("Edge-case consistency checks: PASS (structural only, not a compiler test)")
