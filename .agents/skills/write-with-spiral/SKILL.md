---
name: write-with-spiral
description: Use this skill whenever the user wants Codex to work with Spiral, Write with Spiral, Spiral MCP, writing styles, style guides, writing samples, prompts, knowledge, or workspace-aware drafting through the Spiral MCP server. It helps Codex verify the MCP setup, choose the right Spiral workspace/style/channel, protect private source writing, create or refresh style references, draft in a selected style, compare outputs, and troubleshoot OAuth or stale style problems.
---

# Write with Spiral

Use this skill to operate Spiral from Codex as a style-aware writing system, not just a generic writing assistant.

Spiral has two surfaces Codex may need to coordinate:

- The Spiral MCP server configured in Codex as `spiral`.
- The Spiral web app at `https://app.writewithspiral.com/`, especially workspaces, Styles, Prompts, Knowledge, and Agent/API Keys.

## Confirmed Spiral MCP Tools

Use these tools when the `mcp__spiral` namespace is available in the current Codex session:

| Tool | Use it for | Safety note |
| --- | --- | --- |
| `spiral_onboard` | Readiness/setup flow before writing | Safe first call. |
| `spiral_list_workspaces` | Workspace discovery | Redact IDs unless needed. |
| `spiral_list_styles` | Style discovery | Style names are usually okay, but ask before publishing them. |
| `spiral_voice_status` | Voice readiness and sample count | Safe metadata check. |
| `spiral_check_quota` | Plan/quota status | Safe metadata check. |
| `spiral_list_sessions` | Recent conversation discovery | Session titles may be private; summarize counts by default. |
| `spiral_generate_writing` | New writing from a brief | Use public-safe inputs unless the user confirms otherwise. |
| `spiral_personalize_text` | Rewrite text in the user's voice | Do not feed private text without explicit user intent. |
| `spiral_humanize_text` | Make AI-sounding text read more naturally | Safe with user-provided or synthetic text. |
| `spiral_add_voice_samples` | Add samples to train/update voice | Mutates account data; require explicit approval and sanitized samples. |
| `spiral_list_samples` | Inspect stored samples | Can expose private samples; use only with explicit approval. |
| `spiral_list_drafts` | Inspect drafts in a session | Can expose private drafts; use only for a user-specified or synthetic session. |

Do not claim full MCP coverage unless these tools are visible or a fresh-session test has confirmed them. If this session does not expose `mcp__spiral`, use `codex mcp get spiral` for setup verification and tell the user that direct tool calls require a fresh session or a session where Spiral tools are loaded.

## First Checks

Before using Spiral for a user-facing writing task:

1. Verify the MCP server exists:

   ```bash
   codex mcp get spiral
   ```

2. If it is missing, add and authenticate it:

   ```bash
   codex mcp add spiral --url https://api.writewithspiral.com/mcp/
   codex mcp login spiral
   ```

3. If the MCP was added during the current Codex session but Spiral tools are not visible, say that a fresh Codex session may be needed for tool discovery, then continue with browser/app guidance if useful.

4. Keep secrets out of logs and commits. Do not paste OAuth callback URLs, tokens, private writing samples, or exported social content into public artifacts.

## Decide The Writing Context

Ask or infer these before drafting:

- Workspace: which Spiral workspace should own the style, prompt, or knowledge?
- Style: use an existing style, create a new style, update a style guide, or draft without a style?
- Channel: General, LinkedIn, X/Twitter, email, memo, essay, newsletter, landing page, or another target surface.
- Source material: user-provided notes, URL references, pasted text, uploaded files, Spiral Knowledge, or existing Spiral history.
- Privacy level: public-safe, internal, private, or sensitive.
- Output contract: draft, critique, rewrite, variants, comparison table, prompt, style guide, or implementation checklist.

If the user is vague, pick a safe default:

- Workspace: call `spiral_list_workspaces` when available; otherwise use the current/default workspace.
- Style: call `spiral_list_styles` when available; otherwise ask the user for the style name.
- Channel: General.
- Privacy: public-safe.
- Output: concise draft plus what style/context was applied.

## Spiral Web App Model

Use `references/app-surface.md` when you need live-product orientation.

From the June 4, 2026 app inspection, Spiral exposes:

- Workspace navigation with Styles, Prompts, Knowledge, and Agent/API Keys.
- Personal Styles with sample counts, word counts, style stats, and style cards.
- Style detail pages scoped by workspace and channel.
- Style guide summaries with a full-guide view and update action.
- Reference ingestion through URL, paste text, upload, and read-only social connections.
- Read-only X/Twitter style generation language that says Spiral will not post.
- Style stats such as varied phrasing, grounding in specifics, comparison/ranking, lexical variety, questions, asides, conviction, intensifiers, sentence starts, and prose/bullets mix.

## Core Workflows

### Draft With An Existing Style

1. Verify Spiral MCP and auth.
2. Call `spiral_onboard` or `spiral_voice_status` when available.
3. Call `spiral_list_workspaces` and `spiral_list_styles` when available.
4. Identify workspace, style name, channel, and privacy level.
5. Use `spiral_generate_writing` for new writing or `spiral_personalize_text` for rewriting existing text.
6. Return:
   - final draft
   - style/context used
   - any assumptions
   - one concise improvement option if useful

Do not claim a style was used unless Spiral tools or a user-provided style guide were actually used.

### Humanize AI-Sounding Text

Use `spiral_humanize_text` when the user wants text to read more naturally without necessarily applying their saved voice.

1. Confirm the text is safe to send to Spiral.
2. Call `spiral_humanize_text`.
3. Return the revised text and note that it was humanized, not necessarily personalized to a saved style.

### Create Or Refresh A Style

Use this when the user wants Codex to teach Spiral a voice.

1. Collect 5-15 representative samples or links when possible.
2. Prefer source diversity: short posts, long posts, replies, essays, emails, and high-performing examples when relevant.
3. Remove private identifiers, secrets, client details, and unnecessary personal data before using samples.
4. If using MCP, call `spiral_add_voice_samples` only after explicit approval because it mutates account voice data.
5. If using the web app, add references by URL, paste text, upload, or read-only connection.
6. After Spiral updates the style guide, summarize:
   - sample count and rough source mix
   - channel/workspace scope
   - top style traits
   - gaps in the training set

### Compare Styles Or Channels

Use this when the user wants variants.

Produce a compact comparison:

| Version | Style/channel | Best for | Tradeoff |
| --- | --- | --- | --- |

Then provide the strongest version first. Keep the weaker variants only if they help the decision.

### Build A Spiral Prompt Or Knowledge Asset

Use Prompts for repeatable writing moves. Use Knowledge for reusable source material.

Recommended prompt shape:

```text
Task:
Audience:
Channel:
Style:
Inputs:
Constraints:
What to avoid:
Output format:
```

Use Knowledge for stable context such as product facts, positioning, offer details, audience notes, brand rules, or source documents. Do not put frequently changing draft instructions into Knowledge.

### Troubleshoot

Start with:

```bash
codex mcp get spiral
codex mcp list --json
```

Common cases:

- Missing server: run `codex mcp add spiral --url https://api.writewithspiral.com/mcp/`.
- OAuth expired: run `codex mcp login spiral`.
- Tools not visible after adding server: restart or open a fresh Codex session.
- Wrong style result: confirm workspace, style, channel, and whether the style guide is stale.
- Private sample concern: stop, sanitize samples, and use public-safe examples only.
- Need feature coverage: see `docs/spiral-mcp-coverage.md` in this repo, or run a fresh-session non-mutating test.

## Output Patterns

### Draft Result

```markdown
**Draft**
[draft]

**Spiral Context**
- Workspace: [workspace or unknown]
- Style: [style or none]
- Channel: [channel]
- Sources: [source type only, no private excerpts]
- Confidence: [high/medium/low and why]
```

### Style Audit

```markdown
**Style Health**
- Samples: [count/source mix]
- Strengths: [3 bullets]
- Gaps: [1-3 bullets]
- Recommended next samples: [specific sample types]
```

### Setup Result

```markdown
Spiral MCP is configured as `spiral`.

Verified:
- URL: `https://api.writewithspiral.com/mcp/`
- Auth: OAuth status shown by `codex mcp list`

Next useful check: ask Codex to list Spiral tools in a fresh session if they do not appear here.
```

## Quality Bar

Good Spiral work is:

- grounded in the selected style and channel
- explicit about what was verified
- careful with private writing samples
- short enough to use
- honest about limitations
- inclusive of different writing surfaces: social, email, essays, memos, pages, prompts, and knowledge-backed drafts

Avoid:

- pretending generic rewrites came from Spiral
- exposing private samples in public docs
- flattening every style into punchy social copy
- adding unnecessary setup steps after MCP is already configured
- using Spiral style language as a substitute for user intent
