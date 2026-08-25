---
title: "Migrate Callers, Then Delete Legacy APIs"
tags: [principle, deprecation, migration, api]
status: active
created: 2026-08-26
---

---
name: principle-migrate-callers-then-delete-legacy-apis
description: "Apply when introducing a new internal API while old callers still exist. Migrate callers and delete the old API in the same wave instead of preserving compatibility layers."
disable-model-invocation: true
---

# Migrate Callers Then Delete Legacy APIs

When we decide a new API is the right design, migrate callers and remove the old API in the same refactor wave instead of preserving compatibility layers.

**Rule:**
- Do not keep legacy API paths alive only because internal callers still exist
- Inventory callers, migrate them, and delete the old API immediately
- Treat temporary adapters as exceptional and time-boxed, not default architecture
- Update tests to assert the new contract, and delete tests that only protect pre-refactor implementation details

**When this applies:**
- No external users depend on backward compatibility
- The project can absorb coordinated breaking changes
- The new API is part of a simplification or refactor initiative

Keeping both old and new APIs creates dual-path complexity, slows cleanup, and makes the codebase feel append-only.

---

## Provenance

Original source: https://github.com/cursor/plugins/blob/main/pstack/skills/principle-migrate-callers-then-delete-legacy-apis/SKILL.md

## Anti-patterns (do not do these)

- Reproduce the source verbatim without noting provenance.
- Skip the verification rules below.
- Add a "for now" placeholder without an activation gate.

## Verification rules

- The body matches the upstream source at the version referenced above.
- The skill body fits on one screen for casual reference.
- The skill does not contradict any other skill in this library.
