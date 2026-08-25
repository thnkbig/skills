# Changelog

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
