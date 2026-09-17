"""Check book structure while respecting nested Markdown example fences."""
import json
from pathlib import Path
import re

ROOT=Path(__file__).resolve().parents[1]
errors=[]
evidence=[]
paths=sorted((ROOT/'book/chapters').glob('*.qmd'))
numbers={('1.1' if p.name.startswith('01') else p.name[0]+'.'+p.name[1]):p for p in paths}

def prose_lines(text,path):
    fence=None
    out=[]
    for no,line in enumerate(text.splitlines(),1):
        match=re.match(r'^\s*(`{3,}|~{3,})(.*)$',line)
        if match:
            chars,info=match.groups()
            if fence is None:
                fence=chars
            elif chars[0]==fence[0] and len(chars)>=len(fence) and not info.strip():
                fence=None
            continue
        if fence is None:
            out.append((no,line))
    if fence: errors.append(f'{path}: unclosed code fence')
    return out

for p in paths:
    text=p.read_text(encoding='utf-8')
    prose=prose_lines(text,p.name)
    plain='\n'.join(line for _,line in prose)
    title=re.search(r'^title: "([^"]+)"',text,re.M)
    if not title or not re.match(r'[1-4]\.\d .*\S · [A-Za-z]',title[1]): errors.append(f'{p.name}: bilingual title')
    if title and '# '+title[1] not in plain: errors.append(f'{p.name}: title/H1 mismatch')
    if 'objectives:' not in text.split('---',2)[1] or 'source-note:' not in text.split('---',2)[1]:errors.append(f'{p.name}: metadata')
    required=['## 本章目标','## 前置自测','## Practice Exercise 1','## Practice Exercise 2','## Practice Exercise 3','## Capstone · 压轴项目','## SOURCES · 来源映射']
    indices=[plain.find(h) for h in required]
    if min(indices)<0 or indices!=sorted(indices): errors.append(f'{p.name}: anatomy order')
    if plain.count('## Just Our Opinion')!=1:errors.append(f'{p.name}: opinion count')
    if not text.rstrip().endswith('本章以 CC-BY-SA 4.0 发布。'):errors.append(f'{p.name}: final license')
    if re.search(r'^```\{r',text,re.M):errors.append(f'{p.name}: executable R chunk')
    stack=[]
    for no,line in prose:
        if re.match(r'^:{3,}\s*\{',line): stack.append(no)
        elif re.match(r'^:{3,}\s*$',line):
            if not stack:errors.append(f'{p.name}:{no}: unmatched callout close')
            else:stack.pop()
    if stack:errors.append(f'{p.name}: unclosed callouts {stack}')
    if re.search(r'\[(?:L\d-[A-Z]\d|[1-4]\.\d)\](?!\()',plain):errors.append(f'{p.name}: unresolved reference')
    for label,target in re.findall(r'\[([^\]]+)\]\(([^)]+)\)',plain):
        if '://' in target or target.startswith('#'):continue
        local=(p.parent/target.split('#')[0]).resolve()
        if not local.exists():errors.append(f'{p.name}: broken local link {target}')
    evidence.append(dict(file=p.name,opinion_count=plain.count('## Just Our Opinion'),fences='balanced',callouts='balanced'))
toc=(ROOT/'book/_quarto.yml').read_text(encoding='utf-8')
for unit in range(1,5):
    p=ROOT/f'book/unit-{unit}-map.qmd'
    text=p.read_text(encoding='utf-8')
    links=re.findall(r'\[([1-4]\.\d)\]\(chapters/([^)]*)\)',text)
    expected=[(n,f.name) for n,f in numbers.items() if n.startswith(str(unit)+'.')]
    if links!=expected:errors.append(f'{p.name}: map order/links mismatch')
    if text.count('✅ 已发布')!=len(expected):errors.append(f'{p.name}: status mismatch')
    positions=[toc.find('chapters/'+f) for _,f in links]
    if any(n<0 for n in positions) or positions!=sorted(positions):errors.append(f'{p.name}: TOC mismatch')
result=dict(chapters=len(paths),errors=errors,checks=evidence)
(ROOT/'.qa').mkdir(exist_ok=True)
(ROOT/'.qa/structure.json').write_text(json.dumps(result,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps(dict(chapters=len(paths),errors=errors),ensure_ascii=False))
raise SystemExit(bool(errors))
