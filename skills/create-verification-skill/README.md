# Create Verification Skill

Generates a project-local verification skill that drives the target app the way a user does — any language, framework, or platform. Output lands at `~/.agents/skills/verify-<app>/` on the consuming machine and works against the repo's own dev/run commands rather than a generic recipe.

See `SKILL.md` for the canonical content. This README is a one-paragraph index entry.

## When to reach for it

- A repo has no scripted way to prove UI / CLI / service behavior and reviews are running blind.
- An agent is about to start touching a real app and would benefit from a harness recipe tailored to that repo.
- A new contributor (human or agent) needs a one-shot proof that the app boots and one feature works before deeper changes.

## Translation note

Upstream pstack body and description reference `.cursor/skills/verify-<app>/` (Cursor-specific path) and the slash-command trigger `/create-verification-skill`. Translated to `~/.agents/skills/verify-<app>/` and plain-language trigger for opencode / buzz-acp runtime compatibility. Inner frontmatter keeps `disable-model-invocation: true` — semantic is "load on demand only," valid in any runtime that parses the field.

The `references/feature-map-example/` directory is mirrored verbatim from upstream; the SKILL.md body links to it for the seed-the-feature-map step.