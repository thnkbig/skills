---
title: "ScrapeGraphAI — AI Web Scraping API"
tags: [scraping, extraction, ai, web, llm, api, vendor, probe, scrapegraphai]
status: active
created: 2026-09-14
updated: 2026-09-14
sources:
  - "https://scrapegraphai.com (vendor landing page, fetched 2026-09-14)"
  - "https://scrapegraphai.com/pricing (per-endpoint cost + tier table, fetched 2026-09-14, v2 amendment)"
  - "https://docs.scrapegraphai.com/introduction (V2 docs index, verified 2026-09-14)"
  - "https://docs.scrapegraphai.com/services/scrape (per-format pricing table + auth header name, verified 2026-09-14)"
  - "https://github.com/ScrapeGraphAI/Scrapegraph-ai (OSS library, fetched 2026-09-14)"
  - "https://github.com/ScrapeGraphAI/scrapegraph-mcp (vendor MCP server README, fetched 2026-09-14, v2 amendment)"
trigger: "scrape a website", "extract structured data from a page", "scraping api", "scrapegraph", "scrapegraphai", "scrape to markdown", "scrape to json", "extract company info from url", "ai scraping"
anti_patterns:
  - "Do NOT put the API key in `Authorization: Bearer …` — ScrapeGraphAI uses a custom header `SGAI-APIKEY: $SGAI_APIKEY`. Bearer auth will return 401."
  - "Do NOT use the V1 base URL `https://api.scrapegraphai.com` — V2 lives at `https://v2-api.scrapegraphai.com/api/...`. V1 endpoints will fail or return deprecation errors."
  - "Do NOT assume `markdown` is free — every format is metered. markdown=1, html=1, links=1, images=1, summary=1, json=5, screenshot=2, branding=25 credits. A multi-format call is summed."
  - "Do NOT pull `scrapegraph-py` if you're already on Node (or vice versa) just because the other SDK has the example you want — both SDKs expose the same surface; the cost is the maturity of the example, not which language you use."
  - "Do NOT treat the dashboard tier list as the source of truth for live credit pricing — pricing changes per call. Live values live at https://scrapegraphai.com/pricing; the docs page mirrors them but lags days behind."
  - "Do NOT forget `stealth: true` on any site behind Cloudflare or DataDome — V2's default fetch mode (`auto`) bot-detects and 403s those."
---

---
name: scrapegraphai
description: AI-powered web scraping API. Trigger phrases: 'scrape a website', 'extract structured data from a page', 'scraping api', 'scrapegraph', 'scrapegraphai', 'scrape to markdown', 'scrape to json'. Use when an agent needs structured web data without writing selectors or managing proxies — the API does the LLM-driven extraction. Two SDKs (Python `scrapegraph-py`, Node `scrapegraph-js`), a hosted REST API at `v2-api.scrapegraphai.com`, and a per-format credit meter (markdown=1, json=5, branding=25). Auth is a custom header `SGAI-APIKEY: $SGAI_APIKEY`, not Bearer.
---

# ScrapeGraphAI — AI web scraping API

AI-powered web scraping API and open-source Python library. One call to turn a webpage into markdown, JSON, a screenshot, branding, or any combination. The API does the LLM-driven extraction so callers don't write selectors, manage proxies, or maintain scrapers when sites change layout.

## Why this matters

THNKBIG's agent lanes need clean web data without per-site brittleness. The alternatives have outsized cost in agent time:

- **Hand-written scrapers (BeautifulSoup / Cheerio / Playwright)** — break on JS-heavy sites, need constant maintenance, no structured output unless you wrap an LLM call yourself.
- **Generic LLM-direct fetch** (`fetch url` then `give to Claude`) — works for one-off, doesn't scale (no caching, no credit meter, no retry, no screenshot/JSON formatting), and burns context window.
- **Older scraping SaaS (ScrapingBee, Apify, Bright Data)** — credit-metered but selector-driven. The structured-JSON path runs back through the caller, not the provider.

ScrapeGraphAI picks the LLM-driven approach as the default service: one call, schema-in-schema-out, credit-metered, with JS rendering + stealth + PDF handling + site-wide crawl + change monitoring on the same API.

## 0. Constants — set once per turn

```
BASE_URL=https://v2-api.scrapegraphai.com/api
ENV_VAR=SGAI_APIKEY    # read from secrets.zsh; never paste in chat
HEADER=SGAI-APIKEY      # custom header, NOT Authorization: Bearer
```

The V1 base URL is `https://api.scrapegraphai.com`. **Always use V2.** V1 endpoints return deprecation errors or 404.

Auth header: `SGAI-APIKEY: $SGAI_APIKEY` (verified against the official `/services/scrape` docs page — the header name is not Bearer). A request with `Authorization: Bearer …` returns 401.

Read the key from `~/.zsh/secrets.zsh` with `grep '^export SGAI_APIKEY' … | sed -E 's/^export SGAI_APIKEY="(.*)"$/\1/'`, or have the operator set `export SGAI_APIKEY=…` in the shell. **Never echo the key in chat or in the SKILL.md body.**

## 1. Service surface

Six V2 services, all `POST` JSON at `https://v2-api.scrapegraphai.com/api/<service>`:

| Endpoint   | What it returns                                                                                                                       |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `/scrape`  | A page in one or more formats: `markdown`, `html`, `links`, `images`, `summary`, `json`, `screenshot`, `branding`. Optional `fetchConfig`. |
| `/extract` | Structured data from a URL **or from passed HTML/markdown**, driven by a natural-language `prompt` + optional JSON `schema`.         |
| `/search`  | AI-powered web search that returns structured results (the LLM picks sources, then extracts).                                         |
| `/crawl`   | Async multi-page site crawl with start / stop / resume controls.                                                                      |
| `/monitor` | Cron-scheduled change detection on a page; fires a webhook on diff.                                                                  |
| `/schema`  | Define and reuse JSON schemas across extract calls.                                                                                   |

Other surfaces:

- **`/history`** — browse past request results by id.
- **`/events`** — async events for `crawl` and `monitor`.
- **MCP server** — `github.com/ScrapeGraphAI/scrapegraph-mcp` exposes the same surface over MCP for Agent/Cursor/Claude-Code callers.
- **CLI** — `just-scrape` (npm) wraps the REST API for shell workflows.

## 2. Cost per call — the per-endpoint meter (verified 2026-09-14)

The dominant surprise: **every format in a `scrape` call is metered separately**, not as one scrape. Live `/scrape` per-format table from `/services/scrape`:

| Format       | Credits |
| ------------ | ------- |
| `markdown`   | 1       |
| `html`       | 1       |
| `links`      | 1       |
| `images`     | 1       |
| `summary`    | 1       |
| `json`       | 5       |
| `screenshot` | 2       |
| `branding`   | 25      |

Multi-format calls sum the format costs. The `stealth: true` flag adds 5 credits. `fetchConfig.mode` (`auto` / `fast` / `js`) does not affect cost.

The other V2 endpoints have their own base + modifier shape (live values from `/pricing`, verified 2026-09-14):

| Endpoint | Base cost | Stealth modifier | Formula |
|---|---|---|---|
| `/scrape` | per format (table above) | +5 | `format_base + stealth_modifier`, summed across `formats` array |
| `/extract` (prompt + URL → JSON) | 5 | +5 | one-shot 5 + stealth top-up if `fetchConfig.stealth=true` |
| `/search` (web search + extract) | 2 per result (no prompt) / 5 per result (with prompt) | +5 | `(base + stealth) × num_results` |
| `/crawl` (multi-page) | 2 startup + per-page scrape cost | per-page | `2 + (format_base + stealth) × pages_processed` |
| `/monitor` (cron + change-detection webhook) | format base on each tick | +5 on change detected | `format_base + stealth + change_bonus` |
| PDF processing (inside `/scrape`) | 1 per page actually processed | — | `1 × processed_pages` (default cap: 25 pages via `processors:[pdf]`) |

**Implication for budget planning:** the common "scrape + extract JSON" pattern is 1 + 5 = 6 credits — not 1. A six-format scrape (md + html + links + images + summary + json) is 1+1+1+1+1+5 = 10 credits. Pricing is the actual disincentive to over-fetch.

For PDF: 1 credit per page actually processed (not per requested). `processors: [{type: "pdf", maxPages: 25}]` defaults to a 25-page cap; `-1` means unlimited.

**Tier snapshots** (USD/month, monthly billing, from `/pricing`):

| Tier | $ | API credits | req/min | Monitors | Concurrent crawls |
|---|---|---|---|---|---|
| **Free** | $0 | 500 one-time | 10 | 1 | 1 |
| **Starter** | $20 | 10,000/mo | 100 | 5 | 3 |
| **Growth** (most popular) | $100 | 100,000/mo | 500 | 25 | 15 + basic proxy rotation |
| **Pro** | $500 | 750,000/mo | 5,000 | 100 | 50 + advanced proxy rotation + priority support |
| **Enterprise** | custom | ad-hoc | custom | — | SLA |

One-time top-ups stack forever: 1k credits/$5, 10k/$40, 50k/$150. SOC 2 Type II covers every tier.

## 3. Quick start — the smallest working call

### 3a. cURL (always available, no deps)

```bash
curl -sS -X POST https://v2-api.scrapegraphai.com/api/scrape \
  -H "SGAI-APIKEY: $SGAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url": "https://example.com", "formats": [{"type": "markdown"}]}'
```

### 3b. Python (`scrapegraph-py`)

```python
import os
from scrapegraph_py import ScrapeGraphAI, MarkdownFormatConfig

sgai = ScrapeGraphAI(api_key=os.environ["SGAI_APIKEY"])

res = sgai.scrape(
    "https://example.com",
    formats=[MarkdownFormatConfig()],
)

if res.status == "success":
    md = res.data.results.get("markdown", {}).get("data", [])
    print(md[0] if md else None)
else:
    print("Failed:", res.error)
```

Async client is `AsyncScrapeGraphAI` for `asyncio` callers.

### 3c. Node (`scrapegraph-js` ≥ 2.1.0, Node ≥ 22)

```javascript
import { ScrapeGraphAI } from "scrapegraph-js";

const sgai = new ScrapeGraphAI();  // reads SGAI_APIKEY from env

const res = await sgai.scrape({
  url: "https://example.com",
  formats: [{ type: "markdown" }],
});

if (res.status === "success") {
  console.log(res.data?.results.markdown?.data?);
} else {
  console.error(res.error);
}
```

### 3d. Structured JSON extraction with Pydantic schema

```python
from pydantic import BaseModel
from scrapegraph_py import ScrapeGraphAI, JsonFormatConfig

class Company(BaseModel):
    company_name: str
    tagline: str | None = None

sgai = ScrapeGraphAI()
res = sgai.scrape(
    "https://scrapegraphai.com",
    formats=[
        JsonFormatConfig(
            prompt="Extract the company name and tagline",
            schema=Company.model_json_schema(),
        ),
    ],
)
if res.status == "success":
    parsed = Company.model_validate(res.data.results["json"]["data"])
    print(parsed.company_name, parsed.tagline)
```

Any JSON Schema dict works — Python's `BaseModel.model_json_schema()` is the cheapest path. The JS side passes a plain object with `type: "object", properties: {...}, required: [...]`.

## 4. Fetch modes — when the page doesn't render with default `auto`

```python
from scrapegraph_py import ScrapeGraphAI, MarkdownFormatConfig, FetchConfig

res = sgai.scrape(
    "https://example.com",
    formats=[MarkdownFormatConfig()],
    fetch_config=FetchConfig(
        mode="js",        # "auto" (default), "fast" (no JS), or "js" (full render)
        stealth=True,     # residential proxy + anti-bot headers; +5 credits
        wait=2000,        # ms after page load, 0–30000
        scrolls=3,        # 0–100
        cookies={"session": "abc123"},
        country="us",     # ISO code for geo-targeted proxy
    ),
)
```

| Mode   | When to use                                                          |
| ------ | -------------------------------------------------------------------- |
| `auto` | default — picks cheapest viable per page (cheapest-first)            |
| `fast` | no JS, curl-like fetch; cheaper, breaks on SPAs                      |
| `js`   | full headless render; required for SPAs and post-load JS content     |

`stealth: true` is non-optional on Cloudflare / DataDome / Perimeter-X guarded sites. Test it explicitly: an `auto` call returning markdown but no body text usually means the JS path is needed.

## 5. Response shape — `success` / `error` envelope, results dict

```jsonc
{
  "id": "03907b00-3c10-4b73-a6b5-e3b399a850b1",
  "results": {
    "markdown": { "data": ["# Example Domain\n\n..."] },
    "links":    { "data": ["https://iana.org/domains/example"] }
  },
  "metadata": { "contentType": "text/html" }
}
```

`data` for `markdown` / `html` / `links` / `images` / `summary` is a **list of strings** (the format may have multiple sections — markdown headers, link batches, etc.). `screenshot`/`branding` return `data: { url, width, height, ... }` (screenshot) or `data: { ...brand info... }` (branding). `json.data` is whatever the schema produced — wrap in your Pydantic / Zod / `jsonschema` validator before use.

Error envelope (call-level):
- `401` — missing or invalid `SGAI-APIKEY` (key not set, wrong env-var name, Bearer used by mistake).
- `402` — out of credits; top up at the dashboard.
- `422` — schema validation failed (`json` format with bad schema).
- `429` — rate-limited; back off and retry.

## 6. Survival playbook — the three calls you reach for first

### 6a. "Turn this URL into clean markdown for downstream LLM use"

```bash
curl -sS -X POST https://v2-api.scrapegraphai.com/api/scrape \
  -H "SGAI-APIKEY: $SGAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"url":"https://example.com","formats":[{"type":"markdown","mode":"reader"}]}'
```

`mode: "reader"` strips nav/footers/ads — better signal for downstream LLM ingestion. Costs 1 credit.

### 6b. "Extract structured fields from this page"

```python
res = sgai.scrape(
    url,
    formats=[JsonFormatConfig(
        prompt="Extract company name, product description, pricing tier, contact email",
        schema={
            "type": "object",
            "properties": {
                "company_name": {"type": "string"},
                "description":  {"type": "string"},
                "pricing_tier": {"type": ["string", "null"]},
                "email":        {"type": ["string", "null"]},
            },
            "required": ["company_name"],
        },
    )],
    fetch_config=FetchConfig(mode="js", stealth=True),
)
```

Costs 5 credits. If the page returns empty `data`, the prompt isn't reaching the LLM the way you expect — try the V2 `/extract` service with the URL + the same prompt instead, which has more aggressive retry.

### 6c. "Screenshot a logged-in or JS-heavy page"

```python
res = sgai.scrape(
    url,
    formats=[ScreenshotFormatConfig(
        full_page=True,
        width=1440,
        height=900,
        quality=90,
    )],
    fetch_config=FetchConfig(mode="js", stealth=True, scrolls=3, wait=2000),
)
if res.status == "success":
    screenshot = res.data.results["screenshot"]["data"]
    # screenshot["url"] is a presigned download URL — fetch it immediately
```

Costs 2 (+5 for stealth) credits. `quality` is 1–100 (default 80). `fullPage: false` (default) captures only the viewport.

## 7. Integrations present at vendor level

Per the V2 landing-page listing (verified 2026-09-14): LangChain, LlamaIndex, Vercel AI, LiteLLM, Hermes, OpenClaw, Smithery, CrewAI, Agno, n8n, Zapier, Make.

For an MCP-only integration, prefer the vendor's own `scrapegraph-mcp` server — it exposes `/scrape`, `/extract`, `/search`, `/crawl` as MCP tools. Repository: `github.com/ScrapeGraphAI/scrapegraph-mcp`. If the team needs an MCP wrapper that doesn't already exist, route to a Reed-style infra ticket (per `AGENTS.md` Rule #11).

## 8. Sources verified in this skill

- `https://docs.scrapegraphai.com/services/scrape` — formats table, per-format credit costs, `SGAI-APIKEY` header, fetchConfig field names. **Verified at authoring time + at the 2026-09-14 v2 amendment.**
- `https://docs.scrapegraphai.com/introduction` — service index (the 6 services + history + schema).
- `https://scrapegraphai.com` — marketing positions, integrations list, "V2 better/faster/cheaper" framing.
- `https://scrapegraphai.com/pricing` — per-endpoint base + stealth cost (added 2026-09-14 v2 amendment: `/extract`, `/search`, `/crawl`, `/monitor`, PDF).
- `https://github.com/ScrapeGraphAI/Scrapegraph-ai` — open-source library surface (MIT, 31k stars, BYO-LLM graph pipelines, Scrapfly/Firecrawl-alternative positioning).
- `https://github.com/ScrapeGraphAI/scrapegraph-mcp` — vendor MCP server surface, env vars, tool names (v3 rename migration table), hosted endpoint URL + deprecation note.

Any field not in these six sources — exact per-burst rate limits, regional availability, service-region SLAs — is **not** asserted here. Verify against the live page before quoting numbers to a human.

## 9. Anti-patterns

- **Don't put the key in `Authorization: Bearer`.** V2 uses `SGAI-APIKEY`. Bearer will 401.
- **Don't hit the V1 endpoint.** `https://api.scrapegraphai.com/*` is V1; V2 is `v2-api.scrapegraphai.com/api/*`.
- **Don't sum-multi-format without budgeting.** A naive `formats: [markdown, html, links, images, summary, json]` = 10 credits, not 6. Pick the minimum set the downstream consumer actually needs.
- **Don't skip stealth on protected sites.** Default `auto` will fail on Cloudflare / DataDome. Cost of forgetting: 401/403 instead of 2xx data, with credits still charged on failed calls that reached the route.
- **Don't trust `res.data.results.markdown.data` as a string** — it's a list. `data[0]` is the markdown body, but `data[1..n]` may exist if the page produced multiple chunks. Same for `links.data`, `images.data`.
- **Don't fall back to `/scrape` JSON formatting** when the prompt is the dominant signal — use `/extract` with a `prompt` + `schema` for cleaner structured output and richer retry behavior.
- **Don't call ScrapeGraphAI on internal URLs** (private dashboards, internal services). It's a public-internet scraper; for internal data use the CRM's own API.

## 10. Verification rules

- The provider's `/services/scrape` docs page is the source of truth for: the auth header name, the **per-format** `/scrape` credit cost, and the fetch-config field names. If you cite any of those three in a deliverable without re-reading `/services/scrape` that turn, you've violated this rule.
- The provider's `/pricing` page is the source of truth for: the **per-endpoint** base + stealth costs (the `/extract`, `/search`, `/crawl`, `/monitor`, PDF tables in §2), tier snapshots, and one-time top-up pricing. If you cite any of those in a deliverable without re-reading `/pricing` that turn, you've violated this rule.
- The provider's `scrapegraph-mcp` GitHub README is the source of truth for: the vendor MCP server tool names (v3 rename migration), env vars (`SGAI_API_KEY` canonical, `SGAI_API_URL`, `SGAI_TIMEOUT`), and the hosted endpoint URL `https://sgai-mcp-main.onrender.com` (the legacy `https://mcp.scrapegraphai.com/mcp` is deprecated — not gated by the deprecation notice yet, but new wiring must use onrender).
- A successful 2xx response is necessary but not sufficient for "ScrapeGraphAI works for me" — also check (a) the `markdown.data[0]` body is non-empty and (b) for SPAs, the body contains post-load content. Empty `data: []` is the JS-render failure mode.
- Pricing changes happen without notice (the docs page itself says "see pricing page for full breakdown"). Don't memorize credit counts in durable artifacts; quote the per-format table above for `/scrape` and the per-endpoint table for the other five services, and mark both "verify against `/services/scrape` + `/pricing`."
- The marketing integrations list on the landing page (`LangChain, LlamaIndex, ...`) is verified at authoring time; it grows. Re-check before claiming completeness.

## 11. Activation gates

- **Operator side**: ScrapeGraphAI account created → dashboard → API key generated → `SGAI_APIKEY` exported in `~/.zsh/secrets.zsh` → first curl sanity check returns 2xx (e.g. scrape `https://example.com` markdown for 1 credit).
- **Agent side**: once key is in the agent's shell env, prefer the cURL form (no Python/Node install required); drop to the SDK only when retry/async/cooked-format ergonomics matter.
- **MCP side**: if the agent runtime is MCP-native, prefer `scrapegraph-mcp` over cURL/SDK — exposes the same surface, less per-call code.
- **Cross-machine** (per the skills lib's `scripts/sync-skills.sh`): the skill body is in `~/.buzz/REPOS/thnkbig-skills/skills/scrapegraphai/SKILL.md` and auto-mirrors to `~/.agents/skills/scrapegraphai/` after a `git pull && ./scripts/sync-skills.sh` on each Mac.
