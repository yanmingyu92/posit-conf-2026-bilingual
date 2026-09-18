"""Package authored lab sources deterministically for the book download link."""
from pathlib import Path
import zipfile

root=Path(__file__).resolve().parents[1]
files=[root/'training/README.md',*sorted((root/'training/analysis-handoff').glob('*'))]
for book, language in [('book', 'zh'), ('book-en', 'en')]:
    target=root/book/'downloads/analysis-handoff.zip'
    target.parent.mkdir(parents=True,exist_ok=True)
    with zipfile.ZipFile(target,'w',compression=zipfile.ZIP_DEFLATED) as archive:
        for path in files:
            if path.is_file() and path.suffix in ('.md','.R','.csv'):
                relative=path.relative_to(root)
                source=path
                if language == 'en' and path.suffix == '.md':
                    source=root/'training/en'/path.relative_to(root/'training')
                info=zipfile.ZipInfo(relative.as_posix(),date_time=(2026,9,17,0,0,0))
                info.compress_type=zipfile.ZIP_DEFLATED
                archive.writestr(info,source.read_bytes())
    print(target.relative_to(root))
