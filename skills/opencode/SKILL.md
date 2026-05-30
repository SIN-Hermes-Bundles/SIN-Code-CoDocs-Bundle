---
name: sin-codocs
description: Co-located Docs Standard — jede Code-Datei hat eine `.doc.md` Partner-Datei. Erstelle sie bei neuen Dateien, referenziere sie bei Änderungen. Prüfe auf Broken Links.
---

## CoDocs Standard

Jede Code-Datei bekommt eine `.doc.md` Partner-Datei im selben Ordner.

### Benennung

```
router.py         → router.doc.md
config.yaml       → config.doc.md
api/types.ts      → api/types.doc.md
Makefile          → Makefile.doc.md
```

### Code-Referenz

Erste Zeile der Code-Datei:

```python
# Docs: router.doc.md
```

```ts
// Docs: types.doc.md
```

```makefile
# Docs: Makefile.doc.md
```

### Was in .doc.md gehört

- Was macht diese Datei? (1 Satz)
- Welche anderen Dateien importieren/berührt sie?
- Wichtige Konfig-Werte & Limits
- Warum bestimmte Entscheidungen

### Was NICHT in .doc.md gehört

- Implementation Details (Code spricht für sich)
- Git-Historie (dafür git log)

### Validierung

```bash
grep -rn 'Docs:' --include='*.py' --include='*.ts' --include='*.rs' --include='Makefile' \
  | grep -v '.doc.md' \
  | while IFS=: read -r f _ docref; do
      docfile=$(echo "$docref" | sed 's/.*\/\/ *Docs: *//' | sed 's/.*# *Docs: *//')
      dir=$(dirname "$f")
      [ -f "$dir/$docfile" ] || echo "MISSING: $f -> $docfile"
    done
```

## Ausnahme

- `docs/` Ordner für Architektur-Doku
- README.md für Projekt-Überblick
- KEINE `.doc.md` für reine Config-Dateien ohne Logik (`.gitignore`, etc.)

---

## MarkItDown Integration (Microsoft)

**Convert any file to Markdown** via `markitdown` (CLI) or `from markitdown import MarkItDown` (Python).

Formats: PDF, DOCX, PPTX, XLSX, HTML, Images (OCR), Audio (transcription), YouTube, EPUB, CSV, JSON, XML, ZIP.

### Unterstützte Formate

| Format | CLI | Python |
|--------|-----|--------|
| PDF | `markitdown file.pdf` | `md.convert("file.pdf")` |
| PowerPoint | `markitdown file.pptx` | `md.convert("file.pptx")` |
| Word | `markitdown file.docx` | `md.convert("file.docx")` |
| Excel | `markitdown file.xlsx` | `md.convert("file.xlsx")` |
| Images (EXIF + OCR) | `markitdown photo.jpg` | `md.convert("photo.jpg")` |
| Audio (Transkription) | `markitdown recording.mp3` | `md.convert("recording.mp3")` |
| HTML | `markitdown page.html` | `md.convert("page.html")` |
| CSV / JSON / XML | `markitdown data.csv` | `md.convert("data.csv")` |
| EPUB | `markitdown book.epub` | `md.convert("book.epub")` |
| YouTube URLs | `markitdown https://...` | `md.convert("https://...")` |
| ZIP (iteriert Inhalt) | `markitdown archive.zip` | `md.convert("archive.zip")` |

### Installation

```bash
pipx install markitdown
```

### CLI Usage

```bash
# File → stdout
markitdown document.pdf > document.md

# File → output file
markitdown document.pdf -o document.md

# Pipe
cat document.pdf | markitdown

# With plugins
markitdown --use-plugins document.pdf
```

### Python API

```python
from markitdown import MarkItDown
md = MarkItDown()
result = md.convert("document.pdf")
print(result.text_content)
```

### Integration mit CoDocs

```
input.pdf → markitdown → input.doc.md
```

Bei Altprojekten: `markitdown` erzeugt `.doc.md` aus bestehenden PDFs/Spezs.
