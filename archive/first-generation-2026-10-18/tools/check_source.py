#!/usr/bin/env python3
# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Copyright (c) 2026 Ahmad Ali Parr. All rights reserved.
# Authored by Ahmad Ali Parr.
# Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE.

"""Inventory and conservative structural checks for the M2Lib source tree."""
from pathlib import Path
import re, json, sys
ROOT = Path(__file__).resolve().parents[1]
source = sorted(list((ROOT/'src').rglob('*.def')) + list((ROOT/'src').rglob('*.mod')))
errors=[]
modules={}
for p in source:
    text=p.read_text(errors='replace')
    m=re.search(r'^\s*(DEFINITION|IMPLEMENTATION)\s+MODULE\s+([A-Za-z][A-Za-z0-9_]*)\s*;',text,re.M|re.I)
    if not m:
        errors.append(f'{p.relative_to(ROOT)}: missing module header')
        continue
    kind,name=m.group(1).upper(),m.group(2)
    key=(p.parent,name)
    modules.setdefault(name,[]).append((kind,p))
    if not re.search(r'\bEND\s+'+re.escape(name)+r'\s*\.\s*$',text,re.I|re.S):
        errors.append(f'{p.relative_to(ROOT)}: missing END {name}.')
    if re.search(r'\b(TODO|FIXME|TBD|UNIMPLEMENTED)\b',text,re.I):
        errors.append(f'{p.relative_to(ROOT)}: prohibited placeholder marker')
for name, entries in modules.items():
    kinds=[x[0] for x in entries]
    if len(kinds)!=len(set(kinds)):
        errors.append(f'{name}: duplicate module kind in directory')
    if len(entries)==1 and entries[0][0]=='IMPLEMENTATION':
        errors.append(f'{name}: implementation has no definition module in same directory')
    if len(entries)==1 and entries[0][0]=='DEFINITION':
        errors.append(f'{name}: definition has no implementation module in same directory')
ledger={}
for name, entries in sorted(modules.items()):
    kinds={k for k,_ in entries}
    ledger[name]={'definition': 'IMPLEMENTED' if 'DEFINITION' in kinds else 'BLOCKED',
                  'implementation': 'IMPLEMENTED' if 'IMPLEMENTATION' in kinds else 'BLOCKED',
                  'compiler_status':'BLOCKED' if not __import__('shutil').which('gm2') else 'NOT_STARTED'}
(ROOT/'build'/'verification-ledger.json').write_text(json.dumps(ledger,indent=2)+'\n')
print(f'Source files: {len(source)}')
print(f'Modules: {len(modules)}')
print(f'Source lines: {sum(len(p.read_text(errors="replace").splitlines()) for p in source)}')
print(f'GNU Modula-2 compiler: {__import__("shutil").which("gm2") or "NOT FOUND"}')
if errors:
    print('STRUCTURAL CHECK FAILURES:')
    print('\n'.join('- '+e for e in errors))
    sys.exit(1)
print('Structural inventory checks: PASS (not a compiler or semantic test)')
