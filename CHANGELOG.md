# Changelog

## 2026-08-28

- Added `skills/local-seo-austin-texas/` — THNKBIG canonical city-page SEO for Austin (HQ) + Houston + Dallas + San Antonio + Texas state. Conversion-anchored per the 2026-08-28 reframe (every city page must surface ≥2 regionally-anchored proof categories). Includes canonical NAP, LocalBusiness schema template, meta-title/description/H1 conventions, internal-link targets, city-vs-national CTR baseline, per-city proof requirements, and an Austin worked-example skeleton. Inner frontmatter + body authored by Vision; the editorial ceiling reference is the Editor v2 persona (Section 7 PERSUASION).
- Added 3 THNKBIG SEO/content skills authored by Pepper (sourced from Inbound Square's "B2B Tech Marketing Agency: In-Depth Guide" + the 4 Inbound Square docx; conversion lens anchored on Rudy's 2026-08-28 20:36Z reframe + `GUIDES/service-catalog.md`):
  - `skills/b2b-tech-marketing/` — strategic frame for B2B tech marketing: outsource vs in-house matrix, services taxonomy (planning / traffic / product / tools / website), long-form engineer-authored SEO content as the primary organic lever, multi-agency strategy, and why subject-matter expertise is non-substitutable. THNKBIG application: justifies the in-house agent pipeline (skip/decay/depth detection + Echo/Editor writing+review + Vision SEO lane owner).
  - `skills/inboundsquare-anatomy/` — article template Echo follows and Editor verifies (intro → summary table → detail sections → recommendations → conclusion); voice rules (engineer-to-engineer, second person, present tense, sentence case, plain language); style mechanics (US English, code blocks not screenshots, ≤2 lists per article); the 8-step editorial process that runs across the THNKBIG agent pipeline.
  - `skills/thnkbig-voice-style/` — THNKBIG-specific voice layer sitting on top of Inbound Square anatomy. Three rules: (1) direct/technical/confident (no fence-sitting, name the failure mode, show the math, use the THNKBIG wedge); (2) THNKBIG POV (every article has a position); (3) proof-anchored (case studies, compliance wins, specific deliverables — never a number without a source). Conversion lens (who / wedge / proof / CTA / internal-link path) — every article must answer all five before shipping. Canonical ICP + compliance vocabulary sourced from `GUIDES/service-catalog.md`.
- Updated `CONTEXT.md` pointer text with the 3 new skill triggers (inboundsquare-anatomy, b2b-tech-marketing, thnkbig-voice-style).
- Updated `README.md` active-skills table to list the 3 new skills (status: active).
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
