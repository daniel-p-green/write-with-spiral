# Write with Spiral MCP

Style-aware writing workflows for Codex and [Spiral](https://app.writewithspiral.com/).

This project packages a Codex skill for working with Spiral's MCP server, writing styles, prompts, knowledge, and workspace model. It helps Codex verify Spiral setup, choose the right style and channel, protect private writing samples, and produce drafts that are honest about what was actually used.

## Philosophy

Writing tools get better when every draft leaves behind better reusable context.

Spiral is good at capturing style: examples, style guides, workspace context, and reference material. Codex is good at operating workflows: checking setup, asking the next useful question, transforming inputs, and leaving a trail that can be reused.

This skill connects the two:

- verify the Spiral MCP before relying on it
- select workspace, style, channel, and privacy level before drafting
- use Spiral Styles for voice and Spiral Knowledge for stable source material
- create or refresh styles from representative samples
- compare variants without flattening every voice into generic social copy
- troubleshoot OAuth and stale-style issues without leaking private data

The point is not more ceremony. The point is reusable writing leverage.

## Quick Example

After installing, ask Codex:

```text
Use $write-with-spiral to rewrite this launch note in my LinkedIn style.
Keep it concrete, public-safe, and tell me what Spiral context you used.
```

For a setup check:

```text
Use $write-with-spiral to verify my Spiral MCP setup and tell me whether Codex can use it in this session.
```

For style creation:

```text
Use $write-with-spiral to help me create a Spiral style from essays, short posts, and emails. Start with privacy checks before I paste anything.
```

## Install

First configure Spiral MCP in Codex:

```bash
codex mcp add spiral --url https://api.writewithspiral.com/mcp/
codex mcp login spiral
```

Or add it to `~/.codex/config.toml`:

```toml
[mcp_servers.spiral]
url = "https://api.writewithspiral.com/mcp/"
```

Then run:

```bash
codex mcp login spiral
```

Copy the skill into a Codex-scanned skill location:

```bash
mkdir -p ~/.codex/skills
cp -R .agents/skills/write-with-spiral ~/.codex/skills/
```

Or use the helper:

```bash
./scripts/install-skill.sh
```

Project-local install:

```bash
mkdir -p .agents/skills
cp -R /path/to/write-with-spiral/.agents/skills/write-with-spiral .agents/skills/
```

## Verify

Check Codex MCP configuration:

```bash
codex mcp get spiral
codex mcp list --json
```

Run project checks:

```bash
./scripts/check.sh
```

The local check verifies required skill files, frontmatter, install commands, privacy rules, app-surface notes, README sections, and eval coverage.

See [`docs/verification.md`](./docs/verification.md) for the current verification report.

## What Is Included

```text
.
├── .agents/skills/write-with-spiral/
│   ├── SKILL.md
│   └── references/app-surface.md
├── docs/done-targets.md
├── docs/spiral-mcp-coverage.md
├── docs/verification.md
├── evals/evals.json
├── scripts/check.sh
├── scripts/install-skill.sh
├── AGENTS.md
├── LICENSE
└── README.md
```

## Workflows Covered

- Spiral MCP setup and OAuth verification
- drafting with an existing Spiral style
- generating new writing from a brief
- personalizing existing text in the user's voice
- humanizing AI-sounding text
- creating or refreshing a style from references
- comparing styles and channels
- building reusable Spiral prompts
- separating Spiral Knowledge from prompts and style references
- troubleshooting missing tools, expired OAuth, stale styles, and privacy concerns

## Live App Notes

The bundled app notes come from a privacy-safe Comet inspection of `https://app.writewithspiral.com/writing-styles` on June 4, 2026.

Observed surfaces included:

- workspace navigation
- Styles, Prompts, Knowledge, and Agent/API Keys
- Personal Styles overview
- sample and word counts
- style stats
- style cards
- workspace and channel selectors
- style guide summary and update controls
- reference ingestion through URL, paste text, upload, and read-only connection

No private writing samples are included in this repository.

## Confirmed MCP Coverage

Fresh-session testing confirmed these Spiral MCP tools:

- `spiral_onboard`
- `spiral_list_workspaces`
- `spiral_list_styles`
- `spiral_voice_status`
- `spiral_check_quota`
- `spiral_list_sessions`
- `spiral_generate_writing`
- `spiral_personalize_text`
- `spiral_humanize_text`

The tool surface also exposes `spiral_add_voice_samples`, `spiral_list_samples`, and `spiral_list_drafts`, but those were not called against private account data because they can mutate or reveal samples/drafts.

See [`docs/spiral-mcp-coverage.md`](./docs/spiral-mcp-coverage.md) for the tested matrix.

## Troubleshooting

### Spiral server is missing

```bash
codex mcp add spiral --url https://api.writewithspiral.com/mcp/
codex mcp login spiral
```

### OAuth expired

```bash
codex mcp login spiral
```

### Codex shows Spiral in `codex mcp list` but no tools are visible

Open a fresh Codex session after adding or logging into the MCP server. Tool discovery can lag behind newly added MCP configuration in an already-running session.

### Draft does not sound like the selected style

Check:

- correct workspace
- correct style
- correct channel
- whether the style guide needs to be updated
- whether the source material belongs in Knowledge, a Prompt, or style references

### Privacy concerns

Do not paste secrets, client details, OAuth callback URLs, tokens, private samples, or exported social content into public repos. Sanitize before adding references.

## Limitations

This is not an official Spiral SDK.

It is a Codex skill and companion project for operating Spiral's MCP and app workflow more reliably. The exact MCP tool names may change, so the skill starts with verification and uses the live Spiral app as the source of truth when needed.

The live app notes are a point-in-time inspection from June 4, 2026. Re-check the app before documenting new product behavior.

Prompts, Knowledge, Agent/API Keys, style stats, and style guide update controls were observed in the web app. They are documented as app/browser workflows unless future MCP tool discovery exposes matching tool calls.

## Tests And Evals

Run deterministic checks:

```bash
./scripts/check.sh
```

The eval prompts in [`evals/evals.json`](./evals/evals.json) cover:

- drafting with style context
- creating a new style safely
- debugging MCP visibility without leaking tokens

## License

MIT
