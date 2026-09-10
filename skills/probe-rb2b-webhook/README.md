# probe-rb2b-webhook

Three-tier end-to-end probe for the RB2B → CRM webhook:

1. **Reachability** (no secret, safe for any agent) — confirms the route is alive.
2. **Auth validation** (no real secret) — confirms the secret check is enforced.
3. **Authenticated probe** (operator-only, `OPERATOR_RB2B_SECRET` in env) — creates a real probe Lead so the operator can confirm wire-live end-to-end.

Three probe shapes:

- **3a. Reach-only** — email only, no LinkedIn. Tests the email-set dedupe path.
- **3b. Query-string auth** — same as 3a, but via `?secret=` instead of header.
- **3c. Realistic** — full RB2B shape: LinkedIn + ICP firmographics + Pages Visited + Tags. Exercises the full route including Tags, WebEvent, and intent-tagging.

After every authenticated probe, **delete the probe Lead** (see SKILL.md §4) before reporting "test passed."

The hard rules (no secret persistence, no secret echo, cleanup mandatory, off-hours discipline, no auto-retry on 401) live at the bottom of the SKILL.md — read them before running.

## Files

- `SKILL.md` — full skill body (frontmatter + body)
- `scripts/probe.sh` — bash helper that runs all three checks; takes an optional mode arg (`realistic` | `no-linkedin` | `query-string`)

## Quick start

```bash
# Anonymous reachability + auth check (always safe):
bash skills/probe-rb2b-webhook/scripts/probe.sh

# Authenticated probe (operator-only, creates a real Lead):
OPERATOR_RB2B_SECRET=<value> bash skills/probe-rb2b-webhook/scripts/probe.sh realistic
```
