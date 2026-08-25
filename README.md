# Skills Library

Reusable patterns for agent-using systems: tone, framing, quality, and SOP distillation.

Each skill lives in its own folder under `skills/<skill-name>/` with a `SKILL.md` (frontmatter + body) plus any supporting assets.

## Active skills

| Skill | Purpose | Status |
|-------|---------|--------|
| `skills/unslop/` | Tone, framing, and quality patterns for user-facing copy, knowledge-base artifacts, and skills-library contributions | active |
| `skills/technical-writing/` | Diátaxis + Google dev style + STE + Global English for docs, RFCs, READMEs, PR descriptions | active |
| `skills/grilling/` | Round-by-round interview to stress-test a plan before commit | active |
| `skills/principle-make-operations-idempotent/` | Converge to the same end state across crashes, restarts, retries | active |
| `skills/principle-subtract-before-you-add/` | Remove dead weight, redundant validators, stubs before adding new | active |
| `skills/principle-migrate-callers-then-delete-legacy-apis/` | Update all callers first, then delete the legacy API | active |
| `skills/principle-encode-lessons-in-structure/` | Encode recurring rules as lint, flag, runtime check, or script | active |
| `skills/case-study/` | Distilled case-study creation SOP (10 phases, composite-scenario ethics) | in authoring |

## Repo layout

- `skills/<skill-name>/SKILL.md` - skill body (frontmatter + markdown)
- `skills/<skill-name>/README.md` - skill summary (optional)
- `AGENTS.md` - generic agent adoption patterns
- `CHANGELOG.md` - skills-library version history
- `CONTEXT.md` - cross-skill conventions and guardrails
- `CLAUDE.md` - Claude-specific load instructions (added later)
- `LICENSE` - MIT
- `docs/` - skill-authoring guides
- `scripts/` - utility scripts (validation, lint, etc.)
- `.github/workflows/` - CI for skill validation

## Adding a new skill

1. Create `skills/<skill-name>/SKILL.md` with frontmatter (`title`, `tags`, `status`, `created`) and a markdown body distilled from the canonical source doc.
2. Update `CHANGELOG.md`.
3. Reference the skill from your agent system prompt via the pointer text (canonical format in `CONTEXT.md`).

## Pointer text

The one-line addition that goes into each agent system prompt to make them aware of the skills library:

> When producing user-facing copy, knowledge-base artifacts, or skills-library contributions, fetch the relevant skill body from the thnkbig/skills repo (`skills/<skill-name>/SKILL.md`) for tone, framing, and quality patterns before drafting.

Canonical format documented in `CONTEXT.md`.
