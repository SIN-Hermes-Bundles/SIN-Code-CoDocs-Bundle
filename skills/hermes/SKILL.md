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
- Warum bestimmte Entscheidungen (z.B. "kein async hier weil X")

### Was NICHT in .doc.md gehört

- Implementation Details (Code spricht für sich)
- Git-Historie (dafür git log)

### Validierung

Nach Änderungen prüfen:

```bash
# Broken Links finden
grep -rn 'Docs:' --include='*.py' --include='*.ts' --include='*.rs' --include='Makefile' \
  | grep -v '.doc.md' \
  | while IFS=: read -r f _ docref; do
      docfile=$(echo "$docref" | sed 's/.*\/\/ *Docs: *//' | sed 's/.*# *Docs: *//')
      dir=$(dirname "$f")
      [ -f "$dir/$docfile" ] || echo "MISSING: $f -> $docfile"
    done
```

## Ausnahme

- `docs/` Ordner für Architektur-Doku, ADRs, Setup-Guides
- README.md für Projekt-Überblick
- KEINE `.doc.md` für reine Config-Dateien ohne Logik (`.gitignore`, `.prettierrc`, etc.)

---

## MarkItDown Integration (Microsoft)

**Python-Tool** für LLM-ready Markdown aus: PDF, PowerPoint, Word, Excel, Images (OCR), Audio (Transkription), HTML, CSV/JSON/XML, ZIP, YouTube, EPUB uvm.

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
| Outlook MSG | `markitdown email.msg` | `md.convert("email.msg")` |

### Installation

```bash
# Empfohlen (CLI + Library)
pipx install markitdown

# Oder mit allen optionalen Dependencies
pip install 'markitdown[all]'

# Selektiv (kleinere Installation)
pip install 'markitdown[pdf, docx, pptx]'
```

**Optionale Dependencies:**
| Extra | Aktiviert |
|-------|-----------|
| `[all]` | Alle |
| `[pdf]` | PDF |
| `[docx]` | Word |
| `[pptx]` | PowerPoint |
| `[xlsx]` | Excel |
| `[xls]` | Excel (alt) |
| `[outlook]` | Outlook MSG |
| `[audio-transcription]` | Audio → Text (WAV/MP3) |
| `[youtube-transcription]` | YouTube Transkript |
| `[az-doc-intel]` | Azure Document Intelligence (Cloud OCR) |
| `[az-content-understanding]` | Azure Content Understanding (Video + strukturierte Felder) |

### CLI Usage

```bash
# File → stdout
markitdown document.pdf > document.md

# File → output file
markitdown document.pdf -o document.md

# Pipe
cat document.pdf | markitdown

# Mit Plugins (OCR für eingebettete Bilder)
markitdown --use-plugins document.pdf

# Docker
docker build -t markitdown:latest .
docker run --rm -i markitdown:latest < ~/your-file.pdf > output.md
```

### Python API

```python
from markitdown import MarkItDown

# Basis
md = MarkItDown()
result = md.convert("document.pdf")
print(result.text_content)

# Mit LLM-Bildbeschreibung (PPTX, Images)
from openai import OpenAI
md = MarkItDown(llm_client=OpenAI(), llm_model="gpt-4o")
result = md.convert("presentation.pptx")

# Sicherheitsbewusst: nur lokale Dateien
result = md.convert_local("document.pdf")

# Stream aus eigener Quelle
with open("document.pdf", "rb") as f:
    result = md.convert_stream(f)
```

### Plugins (Community)

Plugins sind **deaktiviert by default** — einschalten mit `--use-plugins`:

```bash
markitdown --use-plugins document.pdf
markitdown --list-plugins
```

**Plugin-Suche:** `#markitdown-plugin` auf GitHub.

**Wichtigstes Plugin:** `markitdown-ocr` — OCR für eingebettete Bilder in PDF/DOCX/PPTX/XLSX via LLM Vision (z.B. GPT-4o):

```bash
pip install markitdown-ocr
pip install openai
```

```python
from markitdown import MarkItDown
from openai import OpenAI

md = MarkItDown(
    enable_plugins=True,
    llm_client=OpenAI(),
    llm_model="gpt-4o",
)
result = md.convert("document_with_images.pdf")
```

### Azure Content Understanding (Cloud)

Für **Video**, **Audio** (bessere Qualität als local) und **strukturierte Feldextraktion** (Rechnungen, Verträge → YAML):

```python
from markitdown import MarkItDown

# Zero-Config: auto-routed per Dateityp
md = MarkItDown(cu_endpoint="<endpoint>")
result = md.convert("report.pdf")   # → prebuilt-documentSearch
result = md.convert("meeting.mp4")  # → prebuilt-videoSearch
result = md.convert("call.wav")     # → prebuilt-audioSearch

# Custom Analyzer für domain-spezifische Felder (YAML Front Matter)
md = MarkItDown(
    cu_endpoint="<endpoint>",
    cu_analyzer_id="my-invoice-analyzer",
)
result = md.convert("invoice.pdf")
# Output: YAML Front Matter mit VendorName, InvoiceDate, ...
```

```bash
# CLI
markitdown path-to-file.pdf --use-cu --cu-endpoint "<endpoint>"
```

**Cost:** Jeder CU-routed `convert()` = billable Azure API Call. Nur bestimmte Formate routen:

```python
from markitdown.converters import ContentUnderstandingFileType
md = MarkItDown(cu_endpoint="<endpoint>",
    cu_file_types=[ContentUnderstandingFileType.PDF])
```

### Azure Document Intelligence (Cloud OCR)

```bash
markitdown document.pdf -o document.md -d -e "<docintel_endpoint>"
```

```python
from markitdown import MarkItDown
md = MarkItDown(docintel_endpoint="<endpoint>")
result = md.convert("scanned.pdf")
```

### Capability Comparison

| Feature | Built-in | Azure Doc Intel | Azure Content Understanding |
|---------|----------|-----------------|-----------------------------|
| Dokumente | Lokal, format-spezifisch | Cloud Layout | Cloud multimodal |
| Strukturierte Felder | ❌ | ❌ | ✅ YAML Front Matter |
| Custom Analyzer | ❌ | ❌ | ✅ `cu_analyzer_id` |
| Audio | Basis | ❌ | ✅ Prebuilt Analyzer |
| Video | ❌ | ❌ | ✅ Prebuilt Analyzer |
| Kosten | Lokal (kostenlos) | Azure API ($$) | Azure API ($$$) |

### Integration mit CoDocs

```
input.pdf → markitdown → input.doc.md
input.pptx → markitdown → input.doc.md
recording.mp3 → markitdown → meeting-notes.doc.md
```

**Pipeline für Altprojekte:**
```bash
for f in docs/*.pdf docs/*.docx docs/*.pptx; do
    markitdown "$f" -o "${f%.*}.doc.md"
done
# Dann # Docs: filename.doc.md in passende Code-Datei einfügen
```

### Security

- `markitdown` hat **volle Dateisystem-Rechte** des aufrufenden Prozesses
- **Niemals untrusted Input direkt an `convert()` übergeben**
- RESTRICTED verwenden: `convert_local()` (nur lokale Dateien), `convert_stream()` (eigene Streams)
- Für Hosted/Server-Umgebungen: Input validieren, Network-Access limitieren

### Referenz

| Topic | Link |
|-------|------|
| Repo | https://github.com/microsoft/markitdown |
| Plugins | https://github.com/microsoft/markitdown → `#markitdown-plugin` |
| PyPI | `pipx install markitdown` oder `pip install markitdown` |
