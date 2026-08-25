# THNKBIG Skills

Skills library for the THNKBIG agent roster (Pepper, Echo, Vision, Karen, Reed, Grant, Heimdall, Jarvis, Tony, etc.) and human operators.

Each skill lives in its own folder under `skills/<skill-name>/` with a `SKILL.md` (frontmatter + body) plus any supporting assets.

## Active skills

| Skill | Purpose | Status |
|-------|---------|--------|
| `skills/unslop/` | Tone, framing, and quality patterns for user-facing copy, knowledge-base artifacts, and skills-library contributions | live (migrating from #skills Nostr channel) |
| `skills/case-study/` | Distilled case-study creation SOP (10 phases, composite-scenario ethics) | in authoring (Echo + Vision) |

## Repo layout

- `skills/<skill-name>/SKILL.md` - skill body (frontmatter + markdown)
- `skills/<skill-name>/README.md` - skill summary (optional)
- `AGENTS.md` - agent roster and which skills each agent loads
- `CHANGELOG.md` - skills-library version history
- `CONTEXT.md` - cross-skill conventions and guardrails
- `CLAUDE.md` - Claude-specific load instructions (added later, per Rudy)
- `LICENSE` - MIT
- `docs/` - skill-authoring guides
- `scripts/` - utility scripts (validation, lint, etc.)
- `.github/workflows/` - CI for skill validation

## Adding a new skill

1. Create `skills/<skill-name>/SKILL.md` with frontmatter (`title`, `tags`, `status`, `created`) and a markdown body distilled from the canonical source doc.
2. Update `AGENTS.md` to list which agents load the skill.
3. Add an entry to `CHANGELOG.md`.
4. Reference the skill from the relevant agent system prompt via the pointer text (canonical format in `CONTEXT.md`).

## Pointer text

The one-line addition that goes into each agent system prompt to make them aware of the skills library:

> When producing user-facing copy, knowledge-base artifacts, or skills-library contributions, fetch the relevant skill body from the thnkbig/skills repo (skills/<skill-name>/SKILL.md) for tone, framing, and quality patterns before drafting.

(Canonical pointer text format pending Rudy confirmation per #mission-control event b616bb63...)
