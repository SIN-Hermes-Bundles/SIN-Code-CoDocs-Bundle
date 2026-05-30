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
