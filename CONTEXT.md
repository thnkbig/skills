# Cross-Skill Conventions and Guardrails

## What every skill must do

1. **Frontmatter**: `title`, `tags`, `status` (`active` | `draft` | `superseded` | `closed`), `created` (YYYY-MM-DD).
2. **Provenance**: every skill carries a source-of-truth doc reference (path, event ID, or URL).
3. **Anti-patterns section**: explicit "do not do these" rules, formatted as bullets.
4. **Verification rules**: claims that need same-session source verification are flagged as such.

## What no skill does

- No skill fabricates data. If a fact is missing, the skill says so.
- No skill recommends an action outside its lane. Handoffs go through `#coordination`.
- No skill ships without an activation gate (who can deploy, who reviews, what the success bar is).

## Pointer text

Canonical format lives here. When new skills are added, append a pointer entry below.

```text
When producing user-facing copy, knowledge-base artifacts, or skills-library contributions, fetch the unslop skill body from #skills (UUID 1667fe61-9268-46f0-9f51-7d51d7d84e2c) for tone, framing, and quality patterns before drafting.
```

(Current pointer points at the legacy Nostr channel. Final canonical text pending Rudy confirmation in #mission-control event b616bb63 - either keep Nostr-channel path or switch to `gh api repos/thnkbig/skills/contents/skills/unslop/SKILL.md`. Body-migration sequencing also pending.)
