---
title: "Laziness Protocol"
tags: [principle, deletion, refactor, simplification]
status: active
created: 2026-08-28
---

---
name: principle-laziness-protocol
description: "Apply when refactoring, evaluating diff size, or tempted to add abstractions, layers, or signal threading. Bias toward deletion and the smallest change that solves the problem."
disable-model-invocation: true
---

# Laziness Protocol

Writing code is cheap for you, which makes over-engineering easy. Counter it by borrowing a human maintainer's fatigue. Aim for the most result with the least code and complexity.

- **Prefer deletion.** When asked to refactor or improve, look for removals before additions.
- **Maintain a flat call hierarchy.** Avoid deep call chains. A rich interface that hides substantial work is not a deep call chain. If answering a question requires tracing through more than 3 files or layers, flatten it.
- **Consolidate decisions.** Do not repeat the same choice in several places. Put it behind one source of truth and pass the result as a simple flag.
- **Minimize the diff.** Make the smallest change that solves the problem. Fewer lines beat "elegant" boilerplate.
- **Question the threading.** If a task asks you to pass a new signal through types, schemas, pipelines, or similar layers, stop and look for a more direct path.
- **Sweat the small leaks.** Remove tiny pass-throughs, representation leaks, and duplicated choices before they spread. Small leaks compound into permanent coordination costs.

**Prime directive:** If a human developer would find the code exhausting to maintain, it is a bad solution. Be lazy. Stay simple.

---

## Provenance

Original source: https://github.com/cursor/plugins/blob/main/pstack/skills/principle-laziness-protocol/SKILL.md

Retrieved 2026-08-28 from upstream pstack for THNKBIG Tier 1 rollout. Inner frontmatter and body are verbatim from upstream.

## Anti-patterns (do not do these)

- Reproduce the source verbatim without noting provenance.
- Skip the verification rules below.
- Add a "for now" placeholder without an activation gate.

## Verification rules

- The body matches the upstream source at the version referenced above.
- The skill body fits on one screen for casual reference.
- The skill does not contradict any other skill in this library.