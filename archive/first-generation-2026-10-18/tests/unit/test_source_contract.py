from pathlib import Path
import re
ROOT=Path(__file__).resolve().parents[2]
def test_every_module_has_definition_and_implementation():
    defs={p.stem for p in (ROOT/'src').rglob('*.def')}
    mods={p.stem for p in (ROOT/'src').rglob('*.mod')}
    assert defs == mods, (sorted(defs-mods), sorted(mods-defs))
def test_module_names_match_filenames():
    for p in list((ROOT/'src').rglob('*.def'))+list((ROOT/'src').rglob('*.mod')):
        text=p.read_text()
        m=re.search(r'^\s*(?:DEFINITION|IMPLEMENTATION)\s+MODULE\s+(\w+)\s*;',text,re.M|re.I)
        assert m, p
        assert m.group(1)==p.stem, (p,m.group(1))
def test_no_placeholder_markers():
    for p in (ROOT/'src').rglob('*'):
        if p.is_file():
            assert not re.search(r'\b(TODO|FIXME|TBD|UNIMPLEMENTED)\b',p.read_text(errors='replace'),re.I), p
def test_module_terminators():
    for p in list((ROOT/'src').rglob('*.def'))+list((ROOT/'src').rglob('*.mod')):
        text=p.read_text()
        assert re.search(r'\bEND\s+'+re.escape(p.stem)+r'\s*\.\s*$',text,re.I|re.S), p
