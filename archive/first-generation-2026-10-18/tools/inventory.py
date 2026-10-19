#!/usr/bin/env python3
# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Copyright (c) 2026 Ahmad Ali Parr. All rights reserved.
# Authored by Ahmad Ali Parr.
# Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE.

from pathlib import Path
import json
root=Path(__file__).resolve().parents[1]
rows=[]
for p in sorted((root/'src').rglob('*')):
    if p.suffix not in ('.def','.mod') or not p.is_file(): continue
    rows.append({'path':str(p.relative_to(root)), 'kind':p.suffix[1:], 'lines':len(p.read_text(errors='replace').splitlines()), 'status':'IMPLEMENTED_UNCOMPILED'})
(root/'build'/'module-inventory.json').write_text(json.dumps(rows,indent=2)+'\n')
print(f'{len(rows)} source files; {sum(x["lines"] for x in rows)} source lines')
for row in rows: print(f'{row["status"]:24} {row["lines"]:4} {row["path"]}')
