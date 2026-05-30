# SIN-Code-CoDocs-Bundle

> [!WARNING]
> **DEPRECATED — moved.** This standard has been merged into the
> **[OpenSIN-Code/SIN-Code-Bundle](https://github.com/OpenSIN-Code/SIN-Code-Bundle)**
> stack and is now a built-in subsystem there. This repository is archived and
> read-only; no further updates will be made here.
>
> - Install: `pip install -e .` from SIN-Code-Bundle, then `sin codocs install-skill`
> - Validate references: `sin codocs check [root]`
> - Docs: [`docs/CODOCS.md`](https://github.com/OpenSIN-Code/SIN-Code-Bundle/blob/main/docs/CODOCS.md)

**Co-located Docs Standard** für Hermes Agent + OpenCode.

Jede Code-Datei bekommt eine `.doc.md` Partner-Datei im selben Ordner.
Einzeilige Referenz in der Code-Datei → `# Docs: datei.doc.md`.

## Skills

| Agent | Install-Pfad |
|-------|-------------|
| Hermes | `skills/hermes/SKILL.md` → `~/.hermes/skills/sin-codocs/SKILL.md` |
| OpenCode | `skills/opencode/SKILL.md` → `~/.config/opencode/skills/sin-codocs/SKILL.md` |

## Quick Install

```bash
# Hermes
mkdir -p ~/.hermes/skills/sin-codocs
cp skills/hermes/SKILL.md ~/.hermes/skills/sin-codocs/

# OpenCode
mkdir -p ~/.config/opencode/skills/sin-codocs
cp skills/opencode/SKILL.md ~/.config/opencode/skills/sin-codocs/
```

## Standard

Siehe [`SKILL.md`](skills/hermes/SKILL.md)

## Tools

| Tool | Install | Nutzung |
|------|---------|---------|
| **MarkItDown** (Microsoft) | `pipx install markitdown` | PDF/Office → `.doc.md` Konvertierung |

## Beispiele

```python
# Docs: router.doc.md
from http.server import HTTPServer
```

→ [`router.doc.md`](example/router.doc.md)

### MarkItDown Pipeline

```bash
markitdown spec.pdf -o spec.doc.md
# → # Docs: spec.doc.md in Code-Datei
```

→ [`markitdown-usage.md`](example/markitdown-usage.md)

---

<!-- gitnexus:start -->
## GitNexus — Repository List

This bundle is part of the **SIN-Hermes-Bundles** group. Repos in `SIN-Hermes-Bundles`:

| Repo | Description |
|------|-------------|
| [SIN-Code-CoDocs-Bundle](https://github.com/SIN-Hermes-Bundles/SIN-Code-CoDocs-Bundle) | Co-located Docs Standard (dieses Repo) |
| [SIN-Hermes-Bundles/SINator-fireworksai](https://github.com/SIN-Hermes-Bundles/SINator-fireworksai) | Fireworks AI API Key Pool + Rotator |

Index: `gitnexus://repo/SIN-Code-CoDocs-Bundle/context`
<!-- gitnexus:end -->
