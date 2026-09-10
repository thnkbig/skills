---
title: "Probe the RB2B → CRM Webhook"
tags: [sales, crm, webhook, rb2b, probe, lead-intake, integration-health, secret-handling]
status: active
created: 2026-09-10
sources:
  - "Original author: Rudy McComb (relay event f2ebcc61450e89acc52be3334b7e03d34da0c6318b078d84b35d438d7157f068, 2026-09-10)"
  - "thnkbig-crm/app/api/webhooks/rb2b/route.ts:29-69 (verifySecret + email-or-LinkedIn gate)"
  - "thnkbig-crm/lib/integration-health.ts (auth_failed / error heartbeat)"
  - "thnkbig-crm/docs/RB2B-DASHBOARD-FILTER.md (RB2B-side ICP gate, independent of CRM-side gate)"
trigger: "test rb2b webhook", "probe rb2b", "is rb2b delivering", "send a test webhook to crm", "rb2b webhook broken", "no new rb2b leads"
anti_patterns:
  - "Do NOT paste the webhook secret in chat, in agent output, in a PR description, or in the skill file. Use it in a single shell invocation then unset."
  - "Do NOT probe during operator off-hours unless a page is active — audit logs every authenticated probe, a flurry looks like an attack."
  - "Do NOT skip the cleanup step (delete the probe Lead) before reporting 'test passed'. A pass means the route works AND the database is back to the pre-test state."
  - "Do NOT auto-retry on 401 — that means the operator's OPERATOR_RB2B_SECRET is stale, not a transient failure."
  - "Do NOT treat a green '200 success:true' probe as proof RB2B is delivering — the probe only proves the route is healthy. RB2B-side dispatch is checked at https://app.rb2b.com/integrations/webhook → Recent deliveries."
---

---
name: probe-rb2b-webhook
description: "Test the RB2B → CRM webhook end-to-end. Trigger phrases: 'test rb2b webhook', 'probe rb2b', 'is rb2b delivering', 'send a test webhook to crm', 'rb2b webhook broken', 'no new rb2b leads'. The skill runs an anonymous reachability check (no secret required, safe for any agent) and, when the operator supplies `OPERATOR_RB2B_SECRET` in env, an authenticated probe that creates a real lead and returns its id. Hard rule: never persist, log, or echo the webhook secret — use it in a single shell-line header and let the process exit clean it up."
---

# Probe the RB2B → CRM webhook

Three checks, ordered from safe-to-any-agent to operator-only.

## 0. Constants — set once per turn

```
PRODUCTION=https://crm.thnkbig.com
PATH=/api/webhooks/rb2b
```

The production URL is `https://crm.thnkbig.com/api/webhooks/rb2b`. There is no
dev/staging URL — the CRM lives only in prod (DigitalOcean App Platform,
NYC region). Don't probe against a local Next.js dev server unless the user
explicitly says they started one.

## 1. Reachability check — always safe (no secret)

```
curl -s -o /dev/null -w 'HTTP %{http_code}\n' -X POST "$PRODUCTION$PATH" \
  -H 'Content-Type: application/json' \
  -d '{}'
```

Expect **HTTP 401** with body `{"error":"Webhook secret is not configured"}`
or `{"error":"Unauthorized"}` depending on whether `RB2B_WEBHOOK_SECRET` is
set server-side. Both prove the endpoint is alive and routed.

If 503: the env var isn't set in the live deployment — the deployment is
broken. Page the operator; do not run more probes.

If 5xx / no response: network or upstream issue. Page the operator.

If 200: something is very wrong with the route — auth is the entire gate,
no valid request can pass without a secret.

## 2. Auth validation — always safe (no real secret, just garbage)

```
curl -s -o /dev/null -w 'HTTP %{http_code}\n' -X POST "$PRODUCTION$PATH" \
  -H 'Content-Type: application/json' \
  -H "x-rb2b-secret: $OPERATOR_RB2B_SECRET_GARBAGE" \
  -d '{"Business Email":"probe@example-corp.io"}'
```

Any non-401 means auth is leaking. A 401 confirms the secret check is
enforced and the integration-heartbeat would record the failure as
`auth_failed` — the same key that caught the 2026-07-23 silent outage.

## 3. Authenticated probe — operator-only, creates a real lead

Requires the operator to set `OPERATOR_RB2B_SECRET` in the shell env.
Never source this from `.env`, never paste it in chat, never store it in
the skill file or any agent artifact. One shell invocation, then the env
is gone when the shell exits.

There are three probe payloads. Pick the one that matches what you're
testing.

### 3a. Reach-only payload (no LinkedIn URL, expected to `success:true` with email-set leads)

```
SECRET="$OPERATOR_RB2B_SECRET"
curl -sS -X POST "$PRODUCTION$PATH" \
  -H 'Content-Type: application/json' \
  -H "x-rb2b-secret: $SECRET" \
  -d '{
    "Business Email": "probe.<unix-ts>@example-corp.io",
    "First Name": "Probe",
    "Last Name": "NoLinkedIn"
  }'
unset SECRET
```

### 3b. Query-string auth variant (same payload via `?secret=`)

```
SECRET="$OPERATOR_RB2B_SECRET"
curl -sS -X POST "$PRODUCTION$PATH?secret=$SECRET" \
  -H 'Content-Type: application/json' \
  -d '{
    "Business Email": "probe.qs.<unix-ts>@example-corp.io",
    "First Name": "ProbeQS",
    "Last Name": "Curl"
  }'
unset SECRET
```

### 3c. Realistic shape (LinkedIn + ICP firmographics + Pages Visited — exercises the full route including Tags, WebEvent, and intent-tagging)

```
SECRET="$OPERATOR_RB2B_SECRET"
curl -sS -X POST "$PRODUCTION$PATH?secret=$SECRET" \
  -H 'Content-Type: application/json' \
  -d '{
    "Business Email": "russel.lee.<unix-ts>@example-corp.io",
    "First Name": "Russel",
    "Last Name": "Lee",
    "LinkedIn URL": "https://www.linkedin.com/in/russellee-thnkbig-probe/",
    "Job Title": "Director of Platform Engineering",
    "Company Name": "Example Corp",
    "Company Industry": "Computer Software",
    "Employee Count": "201-500",
    "Estimate Revenue": "$50M-$100M",
    "Website": "https://example-corp.io",
    "City": "Austin",
    "State": "TX",
    "Country": "United States",
    "Tags": ["ICP","intent:contact-page"],
    "Referrer": "https://www.google.com/search",
    "Pages Visited": [
      {"url":"https://thnkbig.com/blog/bmc-communication-ipmi-redfish/","timestamp":"2026-09-09T14:30:00Z"},
      {"url":"https://thnkbig.com/contact","timestamp":"2026-09-09T14:32:00Z"}
    ],
    "Seen At": "2026-09-09T14:32:00Z"
  }'
unset SECRET
```

### Expected response shape

```
{"success":true,"leadId":"<cuid>","score":<int 0-100>}
```

Anything else:
- `400 {"error":"email or LinkedIn URL is required"}` — payload forgot both identity fields. Fix the payload, don't re-run with the same one.
- `200 {"skipped":"blocked-email-domain"}` — RB2B_BLOCKED_DOMAINS excluded the email AND no LinkedIn was supplied.
- `200 {"skipped":"thnkbig-icp:<reason>"}` — firmographics fell outside the 200/5000 size + $50M revenue gate.
- `401` — secret mismatch. The operator's `OPERATOR_RB2B_SECRET` is stale or copy-pasted wrong. Don't auto-retry.

## 4. Cleanup — REQUIRED after every authenticated probe

Authenticated probes create real Lead rows. Three cleanup modes:

### 4a. Bulk UI delete (preferred when several probes to remove)

`/leads?source=RB2B&company=Example` → select all → Delete. Token-0
deletes don't need approval; cascade is fast.

### 4b. Per-lead UI delete

`/leads/<leadId>` → top-right Delete control. The route deletes the lead
via the standard soft-delete path (`deletedAt` set, `disqualifyReason:
'Deleted by user'`), so the email is freed for re-creation.

### 4c. Prisma direct (only if you have `DATABASE_URL` for prod and explicit operator approval)

```
prisma studio
# Lead table → filter `source = 'RB2B' AND company contains 'Example'`
# bulk select → Delete rows
```

Direct DB deletes bypass the soft-delete audit log. Prefer 4a unless
you're cleaning up after a test that produced too many rows for the UI.

## 5. If the test passes but real RB2B visitors aren't reaching CRM

The route handles traffic correctly when called. If `404`, `5xx`, or
correct `200 success:true` per probe but RB2B's own "Recent deliveries"
tab shows no attempts, the bug is upstream:

```
https://app.rb2b.com/integrations/webhook  →  click "Recent deliveries"
```

Three terminal states per the 2026-07-23 RCA:

| State | Cause | Fix |
|---|---|---|
| **401** entries in delivery log | RB2B on a different secret than DO App Platform | Get RB2B's saved value, diff vs `doctl apps spec get thnkbig-crm`, copy the DO value back into RB2B's dashboard. |
| **2xx** entries but no CRM row | Very rare. Downstream drop. | Page operator with the request body from RB2B's delivery log. |
| **No entries at all** | Webhook disabled, plan downgrade, or feature regression on RB2B's side | Check RB2B's subscription status, re-enable the webhook, open support ticket. |

The current dashboard filter (revenue ≥ $50M, size 201-5000, seniority in
the allowed set, "Required matches" = 5) is documented in
`docs/RB2B-DASHBOARD-FILTER.md`. RB2B's side filter is independent — if
the dashboard is misconfigured, RB2B will silently not deliver, and the
CRM-side ICP gate can't help.

## 6. Hard rules

1. **Never persist the secret.** Use it in a single shell invocation, then
   `unset SECRET` (or close the shell). No `.env`, no agent file, no commit.
2. **Never echo the secret** in agent output, channel posts, or even in
   the curl `--debug-trace` flags. Use `--silent` (`-sS`) but never
   `-v`.
3. **Always clean up probe leads** before reporting "test passed". A pass
   means the route works AND the database is back to the pre-test state.
4. **Don't probe during operator off-hours** unless page is active —
   audit logs every authenticated probe call, and a flurry looks like
   an attack.
5. **If `RB2B_WEBHOOK_SECRET` is unset server-side** (HTTP 503), don't
   run authenticated probes. Page the operator — the production deploy
   is misconfigured and your probes won't represent normal traffic.
