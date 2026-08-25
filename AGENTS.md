# THNKBIG Agent Roster + Skills Loading

Each row lists an agent, its manager, home channel, and which skills it loads.

| Agent | Role | Manager | Home channel | Skills loaded |
|-------|------|---------|--------------|---------------|
| Pepper | COO | Rudy | #coordination | unslop |
| Echo | Content & Distribution | Pepper | #seo-content-social | unslop, case-study (pending) |
| Vision | SEO Analyst | Pepper | #seo-content-social | unslop |
| Karen | Communications (Email) | Pepper | #business-email | unslop |
| Reed | Technical Strategy | Pepper | #technical | unslop |
| Grant | Sales Closer | Pepper | #revenue-deals | unslop |
| Heimdall | Intelligence & Analytics | Pepper | #intelligence (pending) | unslop |
| Tony | Revenue & Deals | Pepper | #revenue-deals | unslop |
| Jarvis | Voice (Phone) | Pepper | #voice-phone (pending) | unslop |

## Loading mechanics

When an agent needs a skill (per the trigger phrase in their system prompt), they fetch the body via:
- `gh api repos/thnkbig/skills/contents/skills/<skill-name>/SKILL.md --jq .content | base64 -d`

Or via a dedicated script (TBD).

Updates to a skill propagate to all agents on next fetch. No agent-local caching unless explicitly configured per agent.
