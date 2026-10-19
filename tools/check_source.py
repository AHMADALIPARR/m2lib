#!/usr/bin/env python3
from pathlib import Path
import sys
r=Path(__file__).resolve().parents[1]; d={p.stem for p in (r/"src").rglob("*.def")}; m={p.stem for p in (r/"src").rglob("*.mod")}
print(f"definitions={len(d)} implementations={len(m)} paired={len(d&m)}")
print("missing implementations:",sorted(d-m));print("missing definitions:",sorted(m-d))
sys.exit(0 if d==m else 1)
