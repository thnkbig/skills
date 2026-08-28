---
title: "Prove It Works"
tags: [principle, verification, artifact, delegation]
status: active
created: 2026-08-28
---

---
name: principle-prove-it-works
description: "Apply after completing a task, before declaring done. Verify against the real artifact (run the feature, read the actual value, inspect the diff), not a proxy, self-report, or 'it compiles.'"
disable-model-invocation: true
---

# Prove It Works

Verify every task output by checking the real thing directly. Do not infer from proxies, self-reports, or "it compiles."

**Why:** Unverified work has unknown correctness. Indirect verification (file mtimes, output freshness, agent self-reports, cached screenshots) feels cheaper than direct observation. Acting on a wrong inference costs far more than checking the source.

**Pattern:** After completing any task, ask: "how do I prove this actually works?"

Check the real thing, not a proxy:
- Check process liveness directly, not indirectly through derived state
- Read the actual value, not a cached or derived representation
- When verification fails, suspect the observation method before suspecting the system

Code and features:
1. Build it (necessary but not sufficient)
2. Run it and exercise the actual feature path
3. Check the full chain: does data flow from input to output?
4. For integrations, test the full communication path end-to-end

Delegation: trust artifacts, not self-reports.
When verifying delegated work, inspect the actual output artifact (git diff, file contents, runtime behavior), not the delegate's summary. Agents report what they intended, not always what happened.

## Script the check when you can

The strongest proof is a deterministic script that re-runs the same comparison, not a one-time eyeball. Write the script, run it, and keep its output as an artifact a reviewer can re-run instead of trusting your word. A script comparing the old and new compiled output catches what a glance misses.

Keep the artifact visible for the human. Commit it only for large or complex work where the trail has to be auditable later, like a big port or migration (the **show-me-your-work** skill). Most work just needs it visible, not committed.

---

## Provenance

Original source: https://github.com/cursor/plugins/blob/main/pstack/skills/principle-prove-it-works/SKILL.md

Retrieved 2026-08-28 from upstream pstack for THNKBIG Tier 1 rollout. Inner frontmatter and body are verbatim from upstream. Cross-reference to `show-me-your-work` skill applies once that skill is mirrored in a later tier.

## Anti-patterns (do not do these)

- Reproduce the source verbatim without noting provenance.
- Skip the verification rules below.
- Add a "for now" placeholder without an activation gate.

## Verification rules

- The body matches the upstream source at the version referenced above.
- The skill body fits on one screen for casual reference.
- The skill does not contradict any other skill in this library.