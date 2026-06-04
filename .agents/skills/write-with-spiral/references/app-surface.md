# Spiral App Surface Notes

Observed in Comet on June 4, 2026 at `https://app.writewithspiral.com/writing-styles`.

These notes are intentionally product-facing and privacy-safe. They describe controls and metadata, not private sample text.

## Navigation

- Spiral uses a workspace sidebar.
- The visible workspace was `Personal`.
- Primary workspace sections were:
  - Styles
  - Prompts
  - Knowledge
  - Agent & API Keys
- The sidebar also showed chat history and workspace settings.

## Styles Overview

- The page heading was `Personal > Styles`.
- Copy explained that Styles teach Spiral how to write like the user and apply writing rules.
- A style summary panel showed aggregate sample and word counts.
- The inspected account showed 50 samples and 7,834 words in the overall style summary.
- Top-level style stats included:
  - Varied phrasing
  - Grounded in specifics
  - Compares and ranks
- Controls included:
  - View style stats
  - Add sample
  - New style
  - Twitter style
  - Individual style cards

## Style Cards

- Style cards show name, summary, example count, and readiness.
- One inspected card was `DG-LinkedIN`.
- Its visible summary described everyday analogies, logical flips, warm/witty accessibility, crisp mobile-friendly structure, curiosity, and experimentation.
- The card showed `13 examples` and `Ready`.

## Style Detail

- Style detail route pattern: `/writing-styles/{style-id}`.
- The style detail page includes:
  - workspace breadcrumb
  - style name
  - `Used in` workspace selector
  - `Channel` selector
  - writing style options menu
  - style guide summary
  - `View full guide`
  - `Update style guide`
  - connections
  - reference ingestion controls

## Reference Inputs

The style detail page offered these reference paths:

- URL
- Paste text
- Upload
- Read-only connection

The inspected style had a LinkedIn reference card showing:

- profile URL
- posts to review
- count used in style

## Style Stats Panel

The overview stats panel included dimensions that are useful for Codex quality checks:

- varied word combinations
- names and numbers per 1,000 words
- comparative words
- lexical variety
- question rate
- asides
- hedge rate
- intensifier rate
- sentence opener distribution
- prose/mixed/bullets distribution

## Privacy And Safety Implications

- Do not export or commit private writing samples.
- Treat social connections as read-only unless the user explicitly asks to connect or change account settings.
- It is safe to document control names, counts, and workflow shape.
- It is not safe to publish private style guide content, OAuth callback URLs, or source posts without explicit approval.

