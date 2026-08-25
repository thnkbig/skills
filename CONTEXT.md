# Cross-Skill Conventions and Guardrails

## What every skill must do

1. **Frontmatter**: `title`, `tags`, `status` (`active` | `draft` | `superseded` | `closed`), `created` (YYYY-MM-DD).
2. **Provenance**: every skill carries a source-of-truth doc reference (path, URL, or document identifier).
3. **Anti-patterns section**: explicit "do not do these" rules, formatted as bullets.
4. **Verification rules**: claims that need same-session source verification are flagged as such.

## What no skill does

- No skill fabricates data. If a fact is missing, the skill says so.
- No skill recommends an action outside its lane. Handoffs go to the appropriate owner.
- No skill ships without an activation gate (who can deploy, who reviews, what the success bar is).

## Pointer text

Canonical format lives here. When new skills are added, append a pointer entry below.

```text
Apply `skills/unslop/` (auto) before sending user-facing prose longer than one paragraph. Apply `skills/technical-writing/` when writing or reviewing docs, RFCs, READMEs, PR descriptions, or commit messages; pick one Diátaxis mode per doc. Use `skills/grilling/` to stress-test a plan or decision round by round before committing. Apply `skills/principle-make-operations-idempotent/` when designing a command, lifecycle step, or processing loop. Apply `skills/principle-subtract-before-you-add/` when sequencing an addition, refactor, or rewrite. Apply `skills/principle-migrate-callers-then-delete-legacy-apis/` when deprecating an API surface. Apply `skills/principle-encode-lessons-in-structure/` when a rule gets repeated.
```
