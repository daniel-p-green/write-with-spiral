# Verification Report

Last verified: June 4, 2026.

## Local MCP

Command:

```bash
codex mcp get spiral
```

Observed:

```text
spiral
  enabled: true
  transport: streamable_http
  url: https://api.writewithspiral.com/mcp/
```

Auth status was also visible in `codex mcp list --json` as OAuth-backed.

## Live App Exploration

Explored with Comet at:

```text
https://app.writewithspiral.com/writing-styles
```

Evidence captured in:

```text
.agents/skills/spiral-codex/references/app-surface.md
```

The notes intentionally avoid private writing samples and OAuth details.

## Project Checks

Command:

```bash
./scripts/check.sh
```

Observed:

```text
evals ok
All checks passed.
```

## Remaining Manual Checks

- Open a fresh Codex session and confirm whether Spiral MCP tools are exposed directly.
- If tool names differ from the skill's generic workflow language, add a tool reference document.
- Re-run Comet exploration before documenting any new Spiral UI behavior.

