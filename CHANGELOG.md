# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial SIN-Code-Bundle integration (ceo-audit workflow v3)
- OpenCode MCP server registration under `OpenSIN-Code/SIN-Code-CoDocs-Bundle`
- Repository-level `SIN_GITHUB_FALLBACK_TOKEN` secret for the App commenter fallback

### Deprecated
- This standard has been merged into the [SIN-Code-Bundle](https://github.com/OpenSIN-Code/SIN-Code-Bundle) stack and is now a built-in subsystem there. This repository is archived and read-only; no further updates will be made here.
  - Install: `pip install -e .` from SIN-Code-Bundle, then `sin codocs install-skill`
  - Validate references: `sin codocs check [root]`

### Security
- All commits verified via `git-immortal-commit` (annotated tags)
