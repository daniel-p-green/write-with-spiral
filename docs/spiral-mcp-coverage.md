# Spiral MCP Coverage

Last tested: June 4, 2026.

Testing used fresh `codex exec` sessions because this desktop session did not expose the newly added `mcp__spiral` namespace directly.

## Tool Discovery

Fresh-session discovery exposed these Spiral MCP tools:

| Tool | Purpose |
| --- | --- |
| `spiral_onboard` | Guided setup/readiness flow before writing. |
| `spiral_list_workspaces` | List personal and team Spiral workspaces. |
| `spiral_list_styles` | List saved writing styles/voices. |
| `spiral_add_voice_samples` | Add writing samples to a workspace or style. |
| `spiral_personalize_text` | Rewrite existing text in the user's voice. |
| `spiral_generate_writing` | Generate new writing from a brief. |
| `spiral_list_sessions` | List recent Spiral writing conversations. |
| `spiral_voice_status` | Check whether the user's writing voice is ready. |
| `spiral_list_drafts` | List drafts from a Spiral conversation. |
| `spiral_check_quota` | Check plan tier and remaining usage. |
| `spiral_humanize_text` | Rewrite AI-sounding text to read more naturally. |
| `spiral_list_samples` | List writing samples currently on file. |

## Read-Only Tests

| Tool | Result | Privacy-safe evidence |
| --- | --- | --- |
| `spiral_list_workspaces` | Succeeded | Returned 1 workspace. |
| `spiral_list_styles` | Succeeded | Returned 1 writing style with 13 samples. |
| `spiral_voice_status` | Succeeded | Voice is set up; reported 50 samples available. |
| `spiral_check_quota` | Succeeded | Plan/usage check returned unlimited usage. |
| `spiral_list_sessions` | Succeeded | Returned 4 recent sessions. |

## Synthetic Writing Tests

All writing tests used synthetic public-safe input only.

| Tool | Result | Evidence |
| --- | --- | --- |
| `spiral_onboard` | Succeeded | Reported writing can proceed. |
| `spiral_generate_writing` | Succeeded | Returned a synthetic field-note draft and a session id for refinement. |
| `spiral_personalize_text` | Succeeded | Rewrote synthetic text in a more natural style. |
| `spiral_humanize_text` | Succeeded | Returned a humanized version of synthetic text. |

## Skipped On Purpose

| Tool | Status | Reason |
| --- | --- | --- |
| `spiral_add_voice_samples` | Not tested | It mutates the user's Spiral voice data. Use only with explicit user approval and sanitized samples. |
| `spiral_list_samples` | Not tested | It can expose private writing samples or source details. Use only when the user explicitly asks and agrees to handling private sample metadata/content. |
| `spiral_list_drafts` | Not tested against private sessions | It requires a session id and can expose private draft content. Use only for a user-specified session or a synthetic session created during the current task. |

## Web-App-Only Surfaces Observed

The Spiral web app also exposes surfaces that were observed but not confirmed as MCP tools:

- Prompts
- Knowledge
- Agent & API Keys
- style stats panels
- style guide full view/update controls
- URL, paste text, upload, and read-only social reference ingestion controls

Treat these as browser/app workflows unless future Spiral MCP tool discovery exposes matching tools.

