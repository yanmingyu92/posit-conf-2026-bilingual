"""Check complete English edition, structural parity, links, and static R fences."""
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
EN = ROOT / 'book-en'
ZH = ROOT / 'book'
errors = []
evidence = []


def prose(text, name):
    fence = None
    lines = []
    for line in text.splitlines():
        match = re.match(r'^\s*(`{3,}|~{3,})(.*)$', line)
        if match:
            chars, info = match.groups()
            if fence is None:
                fence = chars
            elif chars[0] == fence[0] and len(chars) >= len(fence) and not info.strip():
                fence = None
            continue
        if fence is None:
            lines.append(line)
    if fence:
        errors.append(f'{name}: unclosed fence')
    return '\n'.join(lines)


zh_pages = sorted(p.relative_to(ZH) for p in ZH.glob('*.qmd')) + sorted(p.relative_to(ZH) for p in (ZH/'chapters').glob('*.qmd'))
config = (EN/'_quarto.yml').read_text(encoding='utf-8-sig')
if 'author: "Jaime Yan"' not in config or 'lang: en' not in config or 'Corpus Team' in config:
    errors.append('English author or language configuration')
for relative in zh_pages:
    path = EN/relative
    if not path.exists():
        errors.append(f'{relative}: missing English page')
        continue
    text = path.read_text(encoding='utf-8-sig')
    original = (ZH/relative).read_text(encoding='utf-8-sig')
    plain = prose(text, relative)
    if re.search(r'[\u3400-\u9fff]', plain):
        errors.append(f'{relative}: untranslated CJK prose')
    if 'Corpus Team' in text:
        errors.append(f'{relative}: obsolete byline')
    if re.search(r'@@\d+@@', text):
        errors.append(f'{relative}: unresolved translation placeholder')
    if re.search(r'^```\{r', text, re.M):
        errors.append(f'{relative}: executable R chunk')
    if relative.as_posix() not in config:
        errors.append(f'{relative}: missing from TOC')
    for target in re.findall(r'\]\(([^)]+)\)', plain):
        if '://' in target or target.startswith('#'):
            continue
        if not (path.parent/target.split('#')[0]).exists():
            errors.append(f'{relative}: broken link {target}')
    if relative.parent.name != 'chapters':
        continue
    title = re.search(r'^title: "([^"]+)"', text, re.M)
    if not title or '# '+title[1] not in plain:
        errors.append(f'{relative}: title/H1 mismatch')
    metadata = text.split('---', 2)[1]
    if 'objectives:' not in metadata or 'source-note:' not in metadata:
        errors.append(f'{relative}: missing metadata')
    headings = ['## Learning objectives', '## Prerequisite', '## Practice Exercise 1', '## Practice Exercise 2', '## Practice Exercise 3', '## Capstone', '## SOURCES']
    positions = [plain.lower().find(h.lower()) for h in headings]
    if min(positions) < 0 or positions != sorted(positions):
        errors.append(f'{relative}: teaching anatomy/order')
    if plain.count('## Just Our Opinion') != 1:
        errors.append(f'{relative}: opinion count')
    if not text.rstrip().endswith('This chapter is published under CC-BY-SA 4.0.'):
        errors.append(f'{relative}: final license')
    block_count = len(re.findall(r'^```r\s*$', text, re.M))
    original_count = len(re.findall(r'^```r\s*$', original, re.M))
    if block_count != original_count:
        errors.append(f'{relative}: R block count differs ({block_count}/{original_count})')
    opened = len(re.findall(r'^:{3,}\s*\{', plain, re.M))
    closed = len(re.findall(r'^:{3,}\s*$', plain, re.M))
    if opened != closed or opened != len(re.findall(r'^:{3,}\s*\{', prose(original, relative), re.M)):
        errors.append(f'{relative}: callout balance/parity')
    evidence.append({'file': relative.as_posix(), 'r_blocks': block_count, 'callouts': opened})
for unit in range(1, 5):
    original = (ZH/f'unit-{unit}-map.qmd').read_text(encoding='utf-8')
    translated = (EN/f'unit-{unit}-map.qmd').read_text(encoding='utf-8')
    pattern = r'\[([1-4]\.\d)\]\(chapters/([^)]*)\)'
    if re.findall(pattern, original) != re.findall(pattern, translated):
        errors.append(f'unit-{unit}: map link/order parity')
result = dict(pages=len(zh_pages), chapters=len(evidence), r_blocks=sum(row['r_blocks'] for row in evidence), errors=errors, checks=evidence)
(ROOT/'.qa/en').mkdir(parents=True, exist_ok=True)
(ROOT/'.qa/en/structure.json').write_text(json.dumps(result, indent=2), encoding='utf-8')
print(json.dumps({key: value for key, value in result.items() if key != 'checks'}))
raise SystemExit(bool(errors))
