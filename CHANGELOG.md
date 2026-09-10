# Changelog

## 2026-09-10

- Added `skills/probe-rb2b-webhook/` (status: active). SKILL.md authored by Rudy McComb during the 2026-09-09 wire-debug session (relay event `f2ebcc61450e89acc52be3334b7e03d34da0c6318b078d84b35d438d7157f068`), packaged as `probe-rb2b-webhook.tar.gz` and locked in by Pepper on 2026-09-10. Three-tier end-to-end probe: (1) reachability check (no secret, safe for any agent); (2) auth validation (no real secret, garbage header); (3) authenticated probe (operator-only, requires `OPERATOR_RB2B_SECRET` in env, creates a real Lead). Three payload shapes — 3a reach-only, 3b query-string auth, 3c realistic full RB2B shape (LinkedIn + ICP firmographics + Pages Visited + Tags + Referrer). Hard rules baked into the body: never persist/echo the secret, always clean up probe Leads via UI (`/leads?source=RB2B&company=Example` → select all → Delete), don't probe during operator off-hours, no auto-retry on 401. Companion bash helper at `scripts/probe.sh` with mode arg (`realistic` | `no-linkedin` | `query-string`); unsets `SECRET` + `OPERATOR_RB2B_SECRET` before exit. Cross-references: `thnkbig-crm/app/api/webhooks/rb2b/route.ts:29-69` (verifySecret + email-or-LinkedIn gate), `thnkbig-crm/lib/integration-health.ts` (auth_failed / error heartbeat), `thnkbig-crm/docs/RB2B-DASHBOARD-FILTER.md` (RB2B-side ICP gate, independent of CRM-side gate). Trigger phrases: "test rb2b webhook", "probe rb2b", "is rb2b delivering", "send a test webhook to crm", "rb2b webhook broken", "no new rb2b leads". Lands on branch `feat/skill-probe-rb2b-webhook` (this branch, off `main` at `f4b14d2`).
- Updated `README.md` active-skills table (now 19 rows: 18 active + 1 in authoring) with the probe-rb2b-webhook row.

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
