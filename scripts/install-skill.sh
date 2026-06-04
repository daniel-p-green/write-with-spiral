#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-$HOME/.codex/skills}"

mkdir -p "$TARGET"
rm -rf "$TARGET/write-with-spiral"
cp -R "$ROOT/.agents/skills/write-with-spiral" "$TARGET/write-with-spiral"

echo "Installed write-with-spiral skill to $TARGET/write-with-spiral"
echo "Next: ask Codex to use \$write-with-spiral for a Spiral writing workflow."

