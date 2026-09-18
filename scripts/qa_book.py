"""Extract every static R fence, classify, and run in isolated chapter sessions.

Usage: python scripts/qa_book.py --rscript PATH --library PATH [--chapters 01 12]
Raw logs and fixtures stay in .qa; no book code is executed by Quarto.
"""
import argparse
import concurrent.futures
import json
import os
from pathlib import Path
import re
import subprocess
import shutil

ROOT = Path(__file__).resolve().parents[1]
QA = ROOT / os.environ.get('QA_EVIDENCE_DIR', '.qa')
BOOK = ROOT / os.environ.get('QA_BOOK_DIR', 'book')


def extract():
    blocks = []
    for path in sorted((BOOK / 'chapters').glob('*.qmd')):
        source = path.read_text(encoding='utf-8')
        # Also include r fences nested in four-backtick Markdown examples.
        for i, match in enumerate(re.finditer(r'^```r[^\S\n]*\n(.*?)^```[^\S\n]*$', source, re.M | re.S), 1):
            code = match[1]
            chapter = path.stem[:2]
            category, reason, skip = 'RUNNABLE', '', False
            if chapter in ('41', '42', '43', '44', '45', '46'):
                category, reason, skip = 'NEEDS-API', 'No configured LLM credentials; upstream static review; no provider request executed.', True
            elif chapter == '32' or (chapter, i) in [('31', 1), ('31', 3), ('48', 1)]:
                category, reason, skip = 'DEPENDS-ON-FILES', 'Executed separately by qa_book_projects.R in isolated package / renv project.', True
            elif (chapter, i) == ('27', 5):
                category, reason, skip = 'DEPENDS-ON-FILES', 'Interactive IDE reactlog viewer and learner myapp folder; static review only.', True
            elif chapter == '33' and i in (3, 4):
                category, reason, skip = 'DEPENDS-ON-FILES', 'Unspecified exercise functions/data; no invented implementations.', True
            elif chapter == '34' and i in (6, 7):
                category, reason, skip = 'DEPENDS-ON-FILES', 'Requires learner scorekit package / scores_big.csv or heavy_parse implementation.', True
            elif chapter == '14' and i in (6, 7):
                category, reason, skip = 'NEEDS-API', ('Credential template uses example.com; never transmit credentials to placeholder host.' if i == 6 else 'REQRES_API_KEY absent; authenticated third-party pagination reviewed statically.'), True
            elif chapter == '33' and i == 2:
                category, reason = 'INTENTIONALLY-BROKEN', 'Out-of-range tibble column must error.'
            elif chapter == '12' and i == 1:
                category, reason = 'INTENTIONALLY-BROKEN', 'Wrong-year copy/paste example: verify duplicated data, not an exception.'
            elif chapter == '26' and 'p1 + scales::label_percent()' in code:
                category, reason = 'INTENTIONALLY-BROKEN', 'Adding a label formatter as a ggplot layer must error.'
            elif chapter == '14' and i in (4, 5, 7) or chapter == '15' and i == 4:
                category = 'NEEDS-NETWORK'
            elif chapter == '12' and i == 8 or chapter == '34' and i == 3 or chapter == '32':
                category, reason = 'DEPENDS-ON-FILES', 'Minimal survey/scorekit fixture documented in runner.'
            elif re.search(r'library\(|\w+::', code):
                category = 'NEEDS-PKG'
            blocks.append(dict(id=f'{chapter}:{i:02}', chapter=chapter, file=path.relative_to(ROOT).as_posix(), line=source[:match.start()].count('\n')+1, code=code, category=category, reason=reason, skip=skip))
    return blocks


def run_chapter(chapter, blocks, args):
    folder = QA / 'runs' / chapter
    folder.mkdir(parents=True, exist_ok=True)
    (folder / 'data/survey').mkdir(parents=True, exist_ok=True)
    for year in range(2011, 2015):
        data = f'year,score\n{year},70\n{year},90\n'
        (folder / f'data/survey_{year}.csv').write_text(data)
        (folder / f'data/survey/{year}.csv').write_text(data)
    for block in blocks:
        (folder / (block['id'].replace(':', '-')+'.R')).write_text(block['code'], encoding='utf-8')
    (folder / 'manifest.json').write_text(json.dumps(blocks, ensure_ascii=False), encoding='utf-8')
    shutil.copyfile(ROOT/'scripts/qa_book_runner.R', folder/'runner.R')
    env = os.environ.copy()
    env.update(QA_R_LIB=str(Path(args.library).resolve()), LC_ALL='C', LANG='C', RGL_USE_NULL='TRUE', NOT_CRAN='true')
    env['QA_BOOK_DIR'] = str(BOOK.resolve())
    quarto = Path(os.environ.get('TEMP', '')) / 'opencode/quarto/bin/tools'
    env['RSTUDIO_PANDOC'] = str(quarto)
    env['PATH'] = str(quarto) + os.pathsep + env['PATH']
    with (folder / 'run.log').open('w', encoding='utf-8') as log:
        try:
            proc = subprocess.run([args.rscript, '--vanilla', 'runner.R'], cwd=folder, env=env, stdout=log, stderr=subprocess.STDOUT, timeout=900)
            return chapter, proc.returncode
        except subprocess.TimeoutExpired:
            return chapter, 'TIMEOUT'


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--rscript', required=True)
    parser.add_argument('--library', required=True)
    parser.add_argument('--chapters', nargs='*')
    parser.add_argument('--extract-only', action='store_true')
    args = parser.parse_args()
    QA.mkdir(parents=True, exist_ok=True)
    blocks = extract()
    (QA / 'inventory.json').write_text(json.dumps(blocks, ensure_ascii=False, indent=2), encoding='utf-8')
    print(f'Extracted {len(blocks)} blocks across 28 chapters.', flush=True)
    if args.extract_only:
        return
    chapters = sorted({b['chapter'] for b in blocks})
    if args.chapters:
        chapters = [c for c in chapters if c in args.chapters]
    with concurrent.futures.ThreadPoolExecutor(max_workers=3) as pool:
        futures = [pool.submit(run_chapter, c, [b for b in blocks if b['chapter']==c], args) for c in chapters]
        for f in concurrent.futures.as_completed(futures):
            print(f.result(), flush=True)
    results = []
    for path in sorted((QA / 'runs').glob('*/results.jsonl')):
        results.extend(json.loads(line) for line in path.read_text(encoding='utf-8').splitlines() if line)
    project_file = QA / 'project-results.csv'
    if project_file.exists():
        import csv
        for project in csv.DictReader(project_file.open(encoding='utf-8')):
            chapter, num = project['block'].split()[0].split(':')
            key = f'{chapter}:{int(num):02}'
            for result in results:
                if result['id'] == key:
                    result['status'] = ('PARTIAL-IDE' if 'non-IDE' in project['block'] else 'OK') if project['status']=='OK' else 'FAIL'
                    result['detail'] = 'Isolated project fixture; see scripts/qa_book_projects.R.' + (' IDE active-file command not executed.' if 'non-IDE' in project['block'] else '') + project['detail']
    (QA / 'results.json').write_text(json.dumps(results, ensure_ascii=False, indent=2), encoding='utf-8')
    for result in results:
        print(result['id'], result['status'], result.get('detail', '')[:180])
    expected = {b['id'] for b in blocks if b['chapter'] in chapters}
    completed = {r['id'] for r in results}
    failed = [r['id'] for r in results if r['id'] in expected and r['status'].startswith('FAIL')]
    if expected - completed or failed:
        raise SystemExit(f'Incomplete: {sorted(expected-completed)}; failed: {failed}')


if __name__ == '__main__':
    main()
