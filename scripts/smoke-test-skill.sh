#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="${1:-/tmp/write-with-spiral-smoke}"

mkdir -p "$OUT_DIR"

run_codex() {
  local name="$1"
  local prompt="$2"
  local out="$OUT_DIR/${name}.jsonl"

  codex exec --json --dangerously-bypass-approvals-and-sandbox -C "$ROOT" "$prompt" > "$out"
  python3 - "$out" <<'PY'
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
tools = []
messages = []
for line in path.read_text().splitlines():
    try:
        event = json.loads(line)
    except json.JSONDecodeError:
        continue
    item = event.get("item") or {}
    if item.get("type") == "mcp_tool_call" and item.get("server") == "spiral" and item.get("status") == "completed":
        tools.append(item.get("tool"))
    if item.get("type") == "agent_message":
        messages.append(item.get("text", ""))

print(json.dumps({
    "file": str(path),
    "spiral_tools_completed": tools,
    "final_message": messages[-1] if messages else ""
}, indent=2))
PY
}

run_codex "readiness" 'Use $write-with-spiral to verify Spiral MCP readiness for this session. Do not edit files. Do not reveal OAuth tokens, callback URLs, private sample text, draft text, IDs, or private content. Use only safe metadata checks. Return: configured/authenticated, tools visible, voice ready, available styles count, quota status, and limitations.'

run_codex "synthetic-writing" 'Use $write-with-spiral to improve this synthetic public-safe sentence: "This is a test update saying the writing workflow is working." Do not edit files. Use Spiral MCP if available. Do not use private samples, existing drafts, real user content, OAuth tokens, callback URLs, or sample listings. Return only: the revised sentence, which Spiral tool you used, and one sentence explaining why the output is better.'

echo "Smoke test artifacts written to $OUT_DIR"

