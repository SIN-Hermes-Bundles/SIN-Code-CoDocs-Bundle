#!/bin/bash
# SIN-Code-CoDocs-Bundle Installer

set -e

echo "Installing SIN-Code-CoDocs-Bundle..."

# Hermes Skill
mkdir -p ~/.hermes/skills/sin-codocs
cp skills/hermes/SKILL.md ~/.hermes/skills/sin-codocs/
echo "  ✓ Hermes skill → ~/.hermes/skills/sin-codocs/"

# OpenCode Skill
mkdir -p ~/.config/opencode/skills/sin-codocs
cp skills/opencode/SKILL.md ~/.config/opencode/skills/sin-codocs/
echo "  ✓ OpenCode skill → ~/.config/opencode/skills/sin-codocs/"

echo ""
echo "Done. Beide Agenten laden den Skill beim nächsten Start automatisch."
