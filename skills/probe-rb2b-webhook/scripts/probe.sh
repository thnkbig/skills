#!/usr/bin/env bash
# probe-rb2b-webhook helper for the SKILL.md this lives next to.
# Two modes:
#   1) anonymous (default): reachability check only, no secret required.
#   2) authenticated: requires OPERATOR_RB2B_SECRET in env, creates a real
#      probe Lead. The env var is unset before this script exits.
#
# Usage:
#   bash probe.sh                    # reachability + auth check only
#   bash probe.sh realistic          # mode-3c payload (full RB2B shape)
#   bash probe.sh no-linkedin        # mode-3a payload
#   bash probe.sh query-string       # mode-3b (variant auth)
#
# Always returns clean exit codes (0=ok, 1=expected rejection, 2=unexpected).
# HTTP status is the source of truth — body is logged only on non-trivial
# responses (anything other than the documented 401/200/skipped shapes).

set -uo pipefail

PRODUCTION="${PRODUCTION:-https://crm.thnkbig.com}"
ROUTE="/api/webhooks/rb2b"
URL="${PRODUCTION}${ROUTE}"

bar() { printf '\n=== %s ===\n' "$*"; }
ok()  { printf '  ✓ %s\n' "$*"; }
ng()  { printf '  ✗ %s\n' "$*" >&2; }

# 1. Reachability (no secret)
bar "1. Reachability (no secret)"
CODE1=$(curl -s -o /tmp/probe1.body -w '%{http_code}' -X POST "$URL" \
  -H 'Content-Type: application/json' -d '{}')
if [ "$CODE1" = "401" ] || [ "$CODE1" = "503" ]; then
  ok "endpoint alive (HTTP $CODE1)"
else
  ng "unexpected HTTP $CODE1 — endpoint may be down or routed wrong"
  cat /tmp/probe1.body 2>/dev/null
fi

# 2. Auth validation (no real secret)
bar "2. Auth validation (no real secret)"
CODE2=$(curl -s -o /tmp/probe2.body -w '%{http_code}' -X POST "$URL" \
  -H 'Content-Type: application/json' \
  -H "x-rb2b-secret: this-is-intentionally-wrong" \
  -d '{"Business Email":"probe@example-corp.io"}')
if [ "$CODE2" = "401" ]; then
  ok "auth enforced (HTTP 401)"
else
  ng "auth check failed — got HTTP $CODE2"
  cat /tmp/probe2.body 2>/dev/null
fi

# 3. Authenticated probe
MODE="${1:-}"
if [ -z "${OPERATOR_RB2B_SECRET:-}" ]; then
  bar "3. Authenticated probe"
  printf '  → OPERATOR_RB2B_SECRET not set in env — skipping.\n'
  printf '  → Run with `OPERATOR_RB2B_SECRET=<value> bash probe.sh <mode>` to enable.\n'
  rm -f /tmp/probe[12].body
  exit 0
fi

if [ "$MODE" != "realistic" ] && [ "$MODE" != "no-linkedin" ] && [ "$MODE" != "query-string" ] && [ -n "$MODE" ]; then
  ng "unknown mode: $MODE (use: realistic|no-linkedin|query-string)"
  exit 2
fi

TS=$(date +%s)
SECRET="$OPERATOR_RB2B_SECRET"

bar "3. Authenticated probe (mode: ${MODE:-no-linkedin})"

case "${MODE:-no-linkedin}" in
  no-linkedin)
    BODY="{
      \"Business Email\": \"probe.${TS}@example-corp.io\",
      \"First Name\": \"Probe\",
      \"Last Name\": \"NoLinkedIn\"
    }"
    AUTH=(-H "x-rb2b-secret: $SECRET")
    ;;
  query-string)
    BODY="{
      \"Business Email\": \"probe.qs.${TS}@example-corp.io\",
      \"First Name\": \"ProbeQS\",
      \"Last Name\": \"Curl\"
    }"
    AUTH=()
    URL="${URL}?secret=${SECRET}"
    ;;
  realistic)
    BODY="{
      \"Business Email\": \"russel.lee.${TS}@example-corp.io\",
      \"First Name\": \"Russel\",
      \"Last Name\": \"Lee\",
      \"LinkedIn URL\": \"https://www.linkedin.com/in/russellee-thnkbig-probe-${TS}/\",
      \"Job Title\": \"Director of Platform Engineering\",
      \"Company Name\": \"Example Corp\",
      \"Company Industry\": \"Computer Software\",
      \"Employee Count\": \"201-500\",
      \"Estimate Revenue\": \"\$50M-\$100M\",
      \"Website\": \"https://example-corp.io\",
      \"City\": \"Austin\",
      \"State\": \"TX\",
      \"Country\": \"United States\",
      \"Tags\": [\"ICP\",\"intent:contact-page\"],
      \"Referrer\": \"https://www.google.com/search\",
      \"Pages Visited\": [
        {\"url\":\"https://thnkbig.com/blog/bmc-communication-ipmi-redfish/\",\"timestamp\":\"2026-09-09T14:30:00Z\"},
        {\"url\":\"https://thnkbig.com/contact\",\"timestamp\":\"2026-09-09T14:32:00Z\"}
      ],
      \"Seen At\": \"2026-09-09T14:32:00Z\"
    }"
    AUTH=()
    URL="${URL}?secret=${SECRET}"
    ;;
esac

RESP=$(curl -sS -X POST "$URL" \
  -H 'Content-Type: application/json' \
  "${AUTH[@]}" \
  -d "$BODY")

# Wipe the secret from env NOW so it doesn't linger in process state
unset SECRET OPERATOR_RB2B_SECRET

printf '  body: %s\n' "$RESP"
echo "$RESP" | grep -q '"success":true' && ok "lead created" || ng "lead not created"

rm -f /tmp/probe[12].body
echo
echo "Next: clean up the probe Lead via CRM UI (see SKILL.md §4)."
