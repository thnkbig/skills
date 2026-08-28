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
Apply `skills/unslop/` (auto) before sending user-facing prose longer than one paragraph. Apply `skills/technical-writing/` when writing or reviewing docs, RFCs, READMEs, PR descriptions, or commit messages; pick one Diátaxis mode per doc. Use `skills/grilling/` to stress-test a plan or decision round by round before committing. Apply `skills/principle-make-operations-idempotent/` when designing a command, lifecycle step, or processing loop. Apply `skills/principle-subtract-before-you-add/` when sequencing an addition, refactor, or rewrite. Apply `skills/principle-migrate-callers-then-delete-legacy-apis/` when deprecating an API surface. Apply `skills/principle-encode-lessons-in-structure/` when a rule gets repeated. Apply `skills/principle-build-the-lever/` to any non-trivial work — codemod / script / generator / delegate skill beats hand-edits. Apply `skills/principle-laziness-protocol/` when refactoring or evaluating diff size — bias toward deletion. Apply `skills/principle-never-block-on-the-human/` when tempted to ask permission on reversible work — proceed, present, let the human course-correct. Apply `skills/principle-prove-it-works/` after completing a task, before declaring done — verify against the real artifact, not a proxy. Use `skills/bro/` to restate the last message in plain language when responding to a human. Use `skills/create-verification-skill/` to bootstrap a per-repo verification skill against `~/.agents/skills/verify-<app>/`. Apply `skills/b2b-tech-marketing/` when scoping an agency engagement, deciding build-vs-buy for a marketing function, or justifying the shape of an SEO/content publishing program. Apply `skills/inboundsquare-anatomy/` when drafting, reviewing, or scoring any THNKBIG article against the Inbound Square compliance bar (article structure + voice + style + editorial process). Apply `skills/thnkbig-voice-style/` when drafting or reviewing any THNKBIG article — the THNKBIG-specific voice layer that sits on top of Inbound Square anatomy (engineer-with-signing-authority reader, THNKBIG POV, proof-anchored claims, conversion lens). Apply `skills/local-seo-austin-texas/` when reviewing, drafting, or auditing THNKBIG city-page articles (Austin + Houston + Dallas + San Antonio + Texas state cluster); loads canonical NAP, LocalBusiness schema, meta conventions, internal-link targets, and the per-city proof requirements.
```
