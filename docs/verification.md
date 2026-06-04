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
.agents/skills/write-with-spiral/references/app-surface.md
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

## Live Smoke Tests

The repeatable smoke test is:

```bash
./scripts/smoke-test-skill.sh
```

It runs two fresh `codex exec` tasks:

- readiness check using safe metadata only
- synthetic public-safe writing improvement

Expected evidence:

- at least one completed Spiral metadata/status tool in the readiness run
- at least one completed Spiral writing tool in the synthetic writing run
- final answers that do not expose OAuth tokens, callback URLs, private samples, private drafts, or IDs

Latest successful smoke run on June 4, 2026:

- readiness completed `spiral_voice_status`, `spiral_list_styles`, and `spiral_check_quota`
- synthetic writing completed `spiral_voice_status` and `spiral_humanize_text`
- synthetic output: `This test update confirms the writing workflow is working.`

## Spiral MCP Tool Tests

Fresh-session discovery exposed 12 Spiral tools:

```text
spiral_onboard
spiral_list_workspaces
spiral_list_styles
spiral_add_voice_samples
spiral_personalize_text
spiral_generate_writing
spiral_list_sessions
spiral_voice_status
spiral_list_drafts
spiral_check_quota
spiral_humanize_text
spiral_list_samples
```

Read-only calls succeeded for workspace discovery, style discovery, voice status, quota, and recent sessions.

Synthetic public-safe writing calls succeeded for onboarding, generating writing, personalizing text, and humanizing text.

Skipped on purpose:

- `spiral_add_voice_samples`, because it mutates account voice data.
- `spiral_list_samples`, because it can expose private writing samples.
- `spiral_list_drafts` against private sessions, because it can expose private draft content.

See [`spiral-mcp-coverage.md`](./spiral-mcp-coverage.md).

## Remaining Manual Checks

- Open a fresh Codex session and confirm whether Spiral MCP tools are exposed directly.
- If tool names differ from the skill's generic workflow language, add a tool reference document.
- Re-run Comet exploration before documenting any new Spiral UI behavior.
