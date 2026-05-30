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

**Konvertiert alles zu Markdown** für LLM-Konsum: PDF, DOCX, PPTX, XLSX, Images (OCR), Audio, HTML, CSV/JSON/XML, ZIP, YouTube, EPUB, Outlook MSG.

### Installation

```bash
pipx install markitdown                          # Empfohlen
pip install 'markitdown[pdf, docx, pptx, xlsx]'   # Minimal
pip install 'markitdown[all]'                     # Vollständig
```

### CLI

```bash
markitdown file.pdf > file.md                     # stdout
markitdown file.pdf -o file.md                    # Ausgabedatei
cat file.pdf | markitdown                         # Pipe
markitdown --use-plugins file.pdf                 # Mit Plugins
markitdown file.pdf --use-cu --cu-endpoint "<e>"  # Azure Content Understanding
```

### Python API

```python
from markitdown import MarkItDown
md = MarkItDown()
result = md.convert("document.pdf")
print(result.text_content)

# Mit LLM Vision (Bildbeschreibung in PPTX/Images)
from openai import OpenAI
md = MarkItDown(llm_client=OpenAI(), llm_model="gpt-4o")

# Security: nur lokale Dateien
result = md.convert_local("document.pdf")
```

### Plugins

```bash
pip install markitdown-ocr openai
```

```python
md = MarkItDown(enable_plugins=True, llm_client=OpenAI(), llm_model="gpt-4o")
result = md.convert("document_with_images.pdf")
```

### Azure Content Understanding (Cloud)

Für **Video**, **Audio** (besser als lokal), **strukturierte Felder** (Rechnungen → YAML):

```python
md = MarkItDown(cu_endpoint="<endpoint>")
result = md.convert("meeting.mp4")  # → prebuilt-videoSearch
result = md.convert("call.wav")     # → prebuilt-audioSearch

# Custom Analyzer
md = MarkItDown(cu_endpoint="<endpoint>", cu_analyzer_id="my-invoice-analyzer")
result = md.convert("invoice.pdf")  # → YAML Front Matter
```

### Security

- `convert()` hat volle File-IO-Rechte. Niemals untrusted Input übergeben
- Besser: `convert_local()`, `convert_stream()` für kontrollierten Zugriff

### CoDocs Pipeline

```bash
for f in docs/*.pdf docs/*.docx docs/*.pptx; do
    markitdown "$f" -o "${f%.*}.doc.md"
done
```

### Referenz

https://github.com/microsoft/markitdown | `pipx install markitdown`
