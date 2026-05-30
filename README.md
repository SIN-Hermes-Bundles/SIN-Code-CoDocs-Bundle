# SIN-Code-CoDocs-Bundle

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

## Beispiel

```python
# Docs: router.doc.md

from http.server import HTTPServer
```

→ [`router.doc.md`](example/router.doc.md) erklärt Config, Imports, Rationale.

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
