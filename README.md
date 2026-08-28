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
| `skills/principle-build-the-lever/` | Build the codemod / script / generator / delegate skill instead of working by hand | active |
| `skills/principle-laziness-protocol/` | Bias toward deletion and the smallest change that solves the problem | active |
| `skills/principle-never-block-on-the-human/` | Proceed on reversible work; reserve confirmation for irreversible actions | active |
| `skills/principle-prove-it-works/` | Verify against the real artifact, not a proxy, self-report, or "it compiles" | active |
| `skills/bro/` | Restate the last message in plain human language, no jargon | active |
| `skills/create-verification-skill/` | Generates a project-local verification skill that drives the target app the way a user does | active |
| `skills/local-seo-austin-texas/` | City-page SEO for the Austin (HQ) + Houston + Dallas + San Antonio + Texas state cluster. Conversion-anchored (every city page must surface ≥2 regionally-anchored proof categories). | active |
| `skills/b2b-tech-marketing/` | Strategic frame for B2B tech marketing: outsource vs in-house matrix, services taxonomy, long-form engineer-authored SEO as the primary organic lever, subject-matter expertise is non-substitutable. | active |
| `skills/inboundsquare-anatomy/` | Article template Echo follows and Editor verifies (intro + summary table + detail sections + recommendations + conclusion); voice, style mechanics, editorial process. | active |
| `skills/thnkbig-voice-style/` | THNKBIG-specific voice layer: engineer-with-signing-authority reader, THNKBIG POV, proof-anchored claims, conversion lens. | active |
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

## Cross-machine sync (THNKBIG two-machine setup)

After `git pull`, run `scripts/sync-skills.sh` on each machine (macOS, Linux) to mirror the repo's `skills/<name>/SKILL.md` into three local buzz-acp discovery roots and re-create the symlinks. Idempotent — safe to run after every pull. The script is path-agnostic (`$HOME`-based), so the same script works for `acidburn` on the macmini and `madmin` on the macbook without per-machine edits.

```bash
cd ~/.buzz/REPOS/thnkbig-skills   # or wherever the repo is cloned
git pull
./scripts/sync-skills.sh
```

Bootstrapping a fresh machine:

```bash
git clone git@github.com:thnkbig/skills.git ~/.buzz/REPOS/thnkbig-skills
cd ~/.buzz/REPOS/thnkbig-skills
./scripts/sync-skills.sh
```

## Pointer text

The one-line addition that goes into each agent system prompt to make them aware of the skills library:

> When producing user-facing copy, knowledge-base artifacts, or skills-library contributions, fetch the relevant skill body from the thnkbig/skills repo (`skills/<skill-name>/SKILL.md`) for tone, framing, and quality patterns before drafting.

Canonical format documented in `CONTEXT.md`.
