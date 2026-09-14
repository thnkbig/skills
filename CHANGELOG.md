# Changelog

## 2026-09-14

- Added `skills/scrapegraphai/` (status: active). LLM-driven web scraping API + dual SDKs (Python `scrapegraph-py`, Node `scrapegraph-js`) + vendor MCP server (`scrapegraph-mcp`). Auth is custom header `SGAI-APIKEY: $SGAI_APIKEY` (NOT `Authorization: Bearer`), V2 base URL `https://v2-api.scrapegraphai.com/api/...`. Per-format credit meter verified against the official `/services/scrape` docs page (markdown/html/links/images/summary=1, json=5, screenshot=2, branding=25, stealth=+5, multi-format sum). Six V2 services: `/scrape`, `/extract`, `/search`, `/crawl`, `/monitor`, `/schema` + `/history` + `/events`. Body covers the three survival calls (markdown dump, JSON extract, JS-heavy screenshot), fetch modes (`auto`/`fast`/`js` with `stealth` required on Cloudflare/DataDome), and the 9-mile-high anti-patterns (Bearer auth, V1 endpoint, multi-format sum surprise, `markdown.data` is a list not a string). Authored by Reed in #skills after Rudy's "lock this in" message at 16:27:21Z on `https://scrapegraphai.com`. Three sources verified live at authoring time (landing page, `/introduction`, `/services/scrape`); any field outside those three is not asserted. Activation gates: operator creates account → exports `SGAI_APIKEY` in `~/.zsh/secrets.zsh` → first 2xx curl sanity check. Cross-machine sync via the standard `scripts/sync-skills.sh` — body mirrors to `~/.agents/skills/scrapegraphai/` on each Mac.
- Updated `README.md` active-skills table with the `scrapegraphai` row (now 17 rows: 16 active + 1 in authoring).
- Extended `CONTEXT.md` pointer text with the scrapegraphai trigger phrases ("scrape a website", "extract structured data from a page", "scrape to markdown", "scrape to json", "ai scraping").

## 2026-08-28

- Added 6 Tier 1 skills sourced from `cursor/plugins/pstack` (audit: `RESEARCH/PSTACK_SKILLS_AUDIT_2026-08-28.md`):
  - `skills/bro/` — plain-language restatement of the last message
  - `skills/principle-build-the-lever/` — codemod/script beats hand-edits
  - `skills/principle-laziness-protocol/` — bias toward deletion
  - `skills/principle-never-block-on-the-human/` — proceed on reversible work
  - `skills/principle-prove-it-works/` — verify against the real artifact
  - `skills/create-verification-skill/` — per-repo verification bootstrap; body translated from `.cursor/skills/` to `~/.agents/skills/` for non-Cursor runtime; `references/feature-map-example/` mirrored verbatim
- Added `scripts/sync-skills.sh` — idempotent cross-machine sync. For each `skills/<name>/` in the repo, mirrors `SKILL.md` to `$HOME/.agents/skills/<name>/SKILL.md` and creates symlinks at `$HOME/.buzz/.agents/skills/<name>` and `$HOME/.claude/skills/<name>` (the three buzz-acp discovery roots). Path-agnostic via `$HOME`, so the same script works for `acidburn` on the macmini and `madmin` on the macbook.
- Updated `README.md` active-skills table (was 8, now 14) and added a "Cross-machine sync (THNKBIG two-machine setup)" section with bootstrap + recurring-pull commands.
- Extended `CONTEXT.md` pointer text with the 6 new skill triggers.

## 2026-08-26

- Replaced the `skills/unslop/` placeholder with the full body sourced from `cursor/plugins/pstack/skills/unslop/SKILL.md`. Status `draft` -> `active`.
- Added 6 new skills sourced from `cursor/plugins` and `mattpocock/skills`:
  - `skills/technical-writing/` — Diátaxis + Google dev style + STE + Global English
  - `skills/grilling/` — round-by-round stress test of a plan
  - `skills/principle-make-operations-idempotent/` — converge to the same end state across retries
  - `skills/principle-subtract-before-you-add/` — remove dead weight before adding
  - `skills/principle-migrate-callers-then-delete-legacy-apis/` — update all callers, then delete
  - `skills/principle-encode-lessons-in-structure/` — encode recurring rules as lint or runtime checks
- Updated `README.md` active skills table to list all 8 active skills (was 1 placeholder + 1 in authoring).
- Updated the `CONTEXT.md` pointer text to mention the new skill triggers.
## 2026-08-25

- Initial repo created at github.com/thnkbig/skills.
- Layout established: `skills/<name>/` folder pattern, AGENTS.md, README.md, CHANGELOG.md, CONTEXT.md, LICENSE (MIT), .gitignore.
- Skills in flight:
  - `skills/unslop/` - staged, body migration pending.
  - `skills/case-study/` - staged, body in authoring.
- `.claude-plugin/` folder pending.
- Fix pass: genericized public-facing content (removed roster-specific and internal references from README, AGENTS, CONTEXT, and skill placeholders).
