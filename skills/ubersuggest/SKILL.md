---
title: "Ubersuggest"
tags: [seo, keyword-research, backlinks, site-audit, mcp, neil-patel]
status: draft
created: 2026-08-30
sources:
  - "https://ubersuggest-mcp.neilpatelapi.com/mcp"
  - "https://app.neilpatel.com/en/mcp"
  - "GUIDES/UBERSUGGEST_INTEGRATION.md"
---

---

name: ubersuggest
description: Query Neil Patel's Ubersuggest (42 SEO tools across domain analysis, keyword research, backlinks, site audit, AI brand visibility, content, projects, utilities) over the OAuth-authenticated MCP endpoint. Use alongside DataForSEO for cross-validation, not as a replacement.
disable-model-invocation: false

---

Use Ubersuggest as a **second-source SEO data provider** alongside DataForSEO. DataForSEO remains the primary source for keyword/SERP/backlink data; Ubersuggest is the cross-check and the lane for AI brand visibility + content ideas that DataForSEO does not cover.

## Endpoint + auth

- **MCP endpoint:** `https://ubersuggest-mcp.neilpatelapi.com/mcp` (Streamable HTTP, JSON-RPC over SSE — same shape as Firecrawl).
- **Auth:** OAuth 2.0 Bearer. The endpoint returns `401 {"error":"invalid_token","error_description":"Missing Authorization header"}` without a token (verified 2026-08-30). The user's Ubersuggest account token is obtained via the official connector (Claude directory, Cursor, Windsurf, etc.) — paste-back flow follows the Circleback precedent (`GUIDES/CIRCLEBACK_MCP_SETUP.md`).

## Tool surface (42 tools across 8 categories, verified via the marketing page 2026-08-30)

| Category | Tool count | Use it for |
|---|---|---|
| Domain Analysis | 8 | Traffic, keywords, authority, top pages, competitors — overlaps DataForSEO `domain_rank_overview` |
| Keyword Research | 7 | Search volume, difficulty, suggestions, SERP, trends — overlaps DataForSEO `keyword_overview` + `related_keywords` |
| Backlinks | 5 | Backlink profile, referring domains, opportunities — overlaps DataForSEO `backlinks_*` |
| Site Audit | 5 | SEO issues, Core Web Vitals, recommendations — **no DataForSEO equivalent** |
| AI Brand Visibility | 3 | Brand mentions + share of voice across AI answers — **no DataForSEO equivalent** |
| Content | 3 | Content ideas + social sharing data — **no DataForSEO equivalent** |
| Projects | 7 | Rank tracking, monitoring, SEO opportunities — **no DataForSEO equivalent** |
| Utilities | 4 | Site validation, location data — ad-hoc |

## When to call Ubersuggest (vs DataForSEO)

| Need | Default source | Cross-check with Ubersuggest? |
|---|---|---|
| Keyword volume + difficulty for a candidate phrase | DataForSEO | Optional, only when ranges diverge by >30% |
| Domain rank overview / competitor domain | DataForSEO | Yes — Ubersuggest traffic estimates differ; report both |
| SERP top-10 for a keyword | DataForSEO | Optional, low value |
| Backlink profile / referring domains | DataForSEO | Yes — Ubersuggest backlink counts are typically higher; useful for gap detection |
| Site audit / Core Web Vitals / technical SEO issues | **Ubersuggest (only)** | n/a |
| AI brand visibility / share of voice across LLMs | **Ubersuggest (only)** | n/a |
| Content ideas for a topic | **Ubersuggest (only)** | n/a |
| Rank tracking over time | **Ubersuggest (only)** | n/a |
| Site validation (URL status, redirect chains) | **Ubersuggest (only)** | n/a |

## Call shape (curl-capable runtimes: Vision, Heimdall, Tony/ops, Reed)

```bash
curl -s -X POST https://ubersuggest-mcp.neilpatelapi.com/mcp \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json, text/event-stream' \
  -H "Authorization: Bearer $UBERSUGGEST_TOKEN" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{
        "name":"<tool_name>","arguments":{...}}}'
```

Response is SSE; the JSON-RPC result is the first `data:` line.

For native-MCP runtimes (Claude Code/Codex/Cursor/Windsurf): register `https://ubersuggest-mcp.neilpatelapi.com/mcp` as a Streamable-HTTP server with OAuth 2.0 auth, per the per-client setup docs at `https://app.neilpatel.com/en/mcp`.

## Activation gate (do not skip)

This skill is `status: draft` and stays draft until all of the following are true:

1. **Rudy's Ubersuggest account token is wired** — paste-back flow per `GUIDES/CIRCLEBACK_MCP_SETUP.md` adapted for Ubersuggest's OAuth 2.0 (no DCR needed; the connector handles client registration). Token stored at `~/.buzz/.scratch/ubersuggest/tokens.json` (0600).
2. **Live tool smoke passes** — `tools/list` returns the 42 tools, `tools/call` on a single low-cost query (e.g. `site_validation`) returns 200. Logged to `~/.buzz/.scratch/ubersuggest/smoke_results.json`.
3. **Vision/Heimdall prompt blocks updated** — additive pointer (per FIRECRAWL_INTEGRATION.md §prompt-block recipe), routed via draft-update for owner review in Buzz Desktop (NOT orphan-template direct edit for the integration block — only the always-on `unslop`/`technical-writing`/`bro` block lives there).
4. **Per-call cost logged** — Ubersuggest pricing is per-call; track against `RESEARCH/UBERSUGGEST_USAGE_LOG.json` and report monthly in #seo-content-social. Do not exceed the standing cost ceiling without Rudy approval.

## Provenance

- Source: `https://app.neilpatel.com/en/mcp` (marketing page, 2026-08-30 fetch); endpoint shape verified live via `curl` 2026-08-30 against `https://ubersuggest-mcp.neilpatelapi.com/mcp` (HTTP 401 with `invalid_token` confirms OAuth Bearer, JSON-RPC over SSE).
- Tool surface (42 tools / 8 categories) per the marketing page — NOT verified by `tools/list` yet (gate item 2).
- Activation gate mirrors the Firecrawl Integration guide (`GUIDES/FIRECRAWL_INTEGRATION.md`) and the Circleback OAuth paste-back flow (`GUIDES/CIRCLEBACK_MCP_SETUP.md`).

## Anti-patterns (do not do these)

- Do not use Ubersuggest as the **primary** source for keyword volume. DataForSEO is primary; Ubersuggest is cross-check + lane-coverage extension. Cite both when both are pulled.
- Do not paste the OAuth bearer token into a channel post, PR description, or any relay-visible surface. Tokens live at 0600 on the box, never on the relay (MINT-20260818-02 standing rule).
- Do not call the full 42-tool surface from a single brief. Pick the category that matches the question; cite the tool name in the deliverable.
- Do not block a Vision weekly report on a Ubersuggest call failure. Cross-check is value-add; primary report ships on DataForSEO + Clarity (per `OUTBOX/WEEKLY_SEO_REPORT_2026-08-25.md` standing shape).
- Do not assume `tools/list` returns the same 42 tools the marketing page claims until §activation gate 2 verifies it.

## Verification rules

- Endpoint reachability: `curl -s -o /dev/null -w '%{http_code}' https://ubersuggest-mcp.neilpatelapi.com/mcp` returns `401` (auth required, not 404 — proves endpoint exists).
- Auth shape: `curl` without `Authorization` returns `{"error":"invalid_token","error_description":"Missing Authorization header"}` — proves OAuth Bearer, not raw API key.
- Tool surface parity: smoke after gate 2 must show tool counts within ±2 of the marketing page's 42 across the 8 categories. If divergent, file a gap in `RESEARCH/UBERSUGGEST_TOOL_PARITY_2026-08-30.md` before declaring activation.
- Cost ceiling: never exceed 50 calls in a single weekly cycle without explicit Rudy approval (cost-tracking entry required in `RESEARCH/UBERSUGGEST_USAGE_LOG.json`).