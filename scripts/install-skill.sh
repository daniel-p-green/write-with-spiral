#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-$HOME/.codex/skills}"

mkdir -p "$TARGET"
rm -rf "$TARGET/spiral-codex"
cp -R "$ROOT/.agents/skills/spiral-codex" "$TARGET/spiral-codex"

echo "Installed spiral-codex skill to $TARGET/spiral-codex"
echo "Next: ask Codex to use \$spiral-codex for a Spiral writing workflow."

