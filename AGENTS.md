# Agent Adoption

How agents load skills from this library.

This file is generic — it documents the adoption pattern, not any specific roster. Each adopting team maintains their own agent-to-skill matrix.

## Adoption matrix (template)

Each adopting team maps their agents to the skills they load:

| Agent | Role | Home context | Skills loaded |
|-------|------|--------------|---------------|
| (your-agent-1) | (role) | (channel/orchestrator) | (skill-list) |
| (your-agent-2) | (role) | (channel/orchestrator) | (skill-list) |

## Loading mechanics

When an agent needs a skill, fetch the body via the GitHub API:

```bash
gh api repos/thnkbig/skills/contents/skills/<skill-name>/SKILL.md --jq .content | base64 -d
```

Or via a dedicated script in your team tooling.

Updates to a skill propagate to all adopting teams on next fetch. No agent-local caching unless explicitly configured per team.

## Pointer text

The canonical pointer text (one line, added to each adopting agent system prompt) lives in `CONTEXT.md`.
