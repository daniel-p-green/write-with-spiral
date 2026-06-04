# Done Targets

This project is done when all targets below are satisfied.

## Quantified Targets

- Spiral MCP setup is verified with `codex mcp get spiral`.
- The skill includes at least 6 distinct workflows.
- The skill includes at least 5 privacy or safety rules.
- The app surface notes include at least 8 concrete observations from live Spiral exploration.
- The eval set includes at least 3 realistic prompts.
- The check script includes at least 5 deterministic checks.
- The README includes install, quick example, troubleshooting, limitations, and verification sections.
- The repo is public on GitHub and has a pushed commit.

## Verification Gates

Run:

```bash
./scripts/check.sh
```

Optional local MCP check:

```bash
codex mcp get spiral
```

Do not mark the project complete if either the deterministic checks fail or the GitHub repo has not been pushed.

