#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL="$ROOT/.agents/skills/write-with-spiral/SKILL.md"
README="$ROOT/README.md"
EVALS="$ROOT/evals/evals.json"
APP_SURFACE="$ROOT/.agents/skills/write-with-spiral/references/app-surface.md"
COVERAGE="$ROOT/docs/spiral-mcp-coverage.md"

fail() {
  echo "check failed: $*" >&2
  exit 1
}

[[ -f "$SKILL" ]] || fail "missing skill file"
[[ -f "$README" ]] || fail "missing README"
[[ -f "$EVALS" ]] || fail "missing evals"
[[ -f "$APP_SURFACE" ]] || fail "missing app surface notes"
[[ -f "$COVERAGE" ]] || fail "missing Spiral MCP coverage docs"
[[ -x "$ROOT/scripts/install-skill.sh" ]] || fail "install helper must be executable"
[[ -x "$ROOT/scripts/smoke-test-skill.sh" ]] || fail "smoke test helper must be executable"

grep -q '^name: write-with-spiral$' "$SKILL" || fail "skill frontmatter name missing"
grep -q 'description:.*Spiral MCP' "$SKILL" || fail "skill description does not mention Spiral MCP"
grep -q 'codex mcp add spiral --url https://api.writewithspiral.com/mcp/' "$SKILL" || fail "skill missing install command"
grep -q 'Do not claim a style was used unless' "$SKILL" || fail "skill missing honest-use rule"
grep -q 'spiral_generate_writing' "$SKILL" || fail "skill missing generate writing tool"
grep -q 'spiral_personalize_text' "$SKILL" || fail "skill missing personalize tool"
grep -q 'spiral_humanize_text' "$SKILL" || fail "skill missing humanize tool"
grep -q 'spiral_add_voice_samples' "$SKILL" || fail "skill missing voice sample mutation guidance"
grep -q 'spiral_list_samples' "$SKILL" || fail "skill missing sample privacy guidance"
grep -q 'spiral_list_drafts' "$SKILL" || fail "skill missing draft privacy guidance"
grep -q 'URL' "$APP_SURFACE" || fail "app notes missing URL reference path"
grep -q 'Paste text' "$APP_SURFACE" || fail "app notes missing paste text reference path"
grep -q 'Upload' "$APP_SURFACE" || fail "app notes missing upload reference path"
grep -q 'Read-only connection' "$APP_SURFACE" || fail "app notes missing read-only connection reference path"
grep -q '## Quick Example' "$README" || fail "README missing Quick Example"
grep -q '## Troubleshooting' "$README" || fail "README missing Troubleshooting"
grep -q '## Limitations' "$README" || fail "README missing Limitations"
grep -q 'scripts/install-skill.sh' "$README" || fail "README missing install helper"
grep -q 'scripts/smoke-test-skill.sh' "$README" || fail "README missing smoke test helper"
grep -q '## Confirmed MCP Coverage' "$README" || fail "README missing confirmed MCP coverage"
grep -q 'Not tested' "$COVERAGE" || fail "coverage doc missing skipped/untested section"

python3 - "$EVALS" <<'PY'
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
data = json.loads(path.read_text())
evals = data.get("evals", [])
if data.get("skill_name") != "write-with-spiral":
    raise SystemExit("evals skill_name must be write-with-spiral")
if len(evals) < 3:
    raise SystemExit("expected at least 3 evals")
for item in evals:
    if not item.get("prompt") or not item.get("expected_output"):
        raise SystemExit(f"eval {item.get('id')} missing prompt or expected_output")
    if len(item.get("assertions", [])) < 3:
        raise SystemExit(f"eval {item.get('id')} needs at least 3 assertions")
print("evals ok")
PY

workflow_count="$(grep -c '^### ' "$SKILL")"
[[ "$workflow_count" -ge 6 ]] || fail "expected at least 6 skill workflows/sections, found $workflow_count"

privacy_count="$(grep -Ei 'private|privacy|secret|token|OAuth|sample|callback' "$SKILL" "$APP_SURFACE" | wc -l | tr -d ' ')"
[[ "$privacy_count" -ge 5 ]] || fail "expected at least 5 privacy/safety mentions, found $privacy_count"

observation_count="$(grep -E '^- ' "$APP_SURFACE" | wc -l | tr -d ' ')"
[[ "$observation_count" -ge 8 ]] || fail "expected at least 8 app observations, found $observation_count"

echo "All checks passed."
