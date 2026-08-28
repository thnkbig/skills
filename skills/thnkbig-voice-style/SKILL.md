---
title: "THNKBIG Voice Style — Direct, Technical, Confident, Proof-Anchored"
tags: [voice, style, thnkbig, conversion, icp, content]
status: active
created: 2026-08-28
---

---
name: thnkbig-voice-style
description: "THNKBIG-specific voice layer that sits on top of the Inbound Square article anatomy. Three rules: speak to engineers with signing authority (not beginners); take a THNKBIG POV (no '10 options, you decide' fence-sitting); anchor every claim in proof (case studies, metrics, compliance wins). Apply when drafting or reviewing any THNKBIG article. Pair with `inboundsquare-anatomy` for structure and `b2b-tech-marketing` for strategy."
---

# THNKBIG voice style

The Inbound Square anatomy gives Echo the article shape. The `unslop` skill strips AI tells. This skill adds the THNKBIG layer: who we are writing to, what we are willing to say, and what every claim has to carry.

## Reader

THNKBIG writes for one reader:

- **C-level or VP at a regulated enterprise** (financial services, defense, healthcare, energy) running a VMware → Kubernetes migration, **or**
- **VP planning an AI initiative** that has hit the demo-to-production gap.

The reader has signing authority. The reader's time is expensive. The reader will not read SEO-optimized boilerplate.

Write to that reader. Not to beginners, not to "anyone interested in cloud native," not to "developers looking to upskill."

## Voice — three rules

### 1. Direct, technical, confident

- Take a position. "Use VPA for memory-bound workloads, HPA for CPU-bound" beats "depending on your workload, you might choose VPA or HPA."
- Show the math. "$340K/month GPU spend at 94% utilization after stabilization, down from $1.2M/month" beats "we saved significant GPU costs."
- Name the failure mode. "The demo-to-production gap is where 70% of AI initiatives die" beats "many AI projects struggle to reach production."
- Use the THNKBIG wedge. Kubernetes Consulting, AI Infrastructure, FedRAMP/IL-5/HIPAA/SOC 2/PCI compliance. Don't pretend we are a generic IT shop.

### 2. THNKBIG POV, not "options for you to choose"

- Every article has a point of view. If you can't state it in one sentence, the article is not done.
- Fence-sitting ("here are 10 options, you decide") is a failure mode. The reader came for an opinion.
- The POV is grounded in THNKBIG's 200+ production clusters, Fortune 500 case studies, and the canonical service catalog (Kubernetes Consulting + AI Infrastructure as Tier 1; Tier 2 services as supporting context).

### 3. Proof-anchored

Every quantitative or capability claim lands with a source. Three source types, in this priority order:

1. **Published case studies on thnkbig.com** — energy ($850K/yr savings, 50x deploy freq, SOC 2 first-attempt pass), defense (IL-5 GovCloud in 90 days), healthcare (HIPAA in 60 days), AI infra ($340K/mo saved, 94% GPU utilization, 2wk to first savings).
2. **Compliance wins** — FedRAMP, IL-4/IL-5, GovCloud, HIPAA, SOC 2, PCI-DSS, NIST 800-53, CMMC, ITAR. Used correctly, with the right framework cited.
3. **Specific deliverables** — "H100/A100/L40S, KServe, Triton, vLLM, MIG partitioning." "VMware → K8s migration, 200+ production clusters."

Forbidden without verification: any number not in a case study, any compliance framework name used incorrectly, any client name from the forbidden list (Five9, Clearbridge, AHEAD). Substitute: "a Nasdaq-listed cloud contact center SaaS vendor (top-5 in segment)" if a comparable proof point is needed.

## Conversion lens

Every article answers five questions before it ships:

| Question | What it means |
|---|---|
| **Who is this for?** | The named ICP — C-level/VP at a regulated enterprise doing VMware → K8s, or VP planning AI initiatives past the demo→production gap. If the article doesn't name that reader, it's the wrong article. |
| **What's the THNKBIG wedge?** | Which Tier 1 service this article points at (Kubernetes Consulting or AI Infrastructure), and which Tier 2 services support it. |
| **What proof anchors the claims?** | One case study + one compliance reference + one specific deliverable, minimum. |
| **What's the CTA?** | A natural next step for the reader: a discovery call, an assessment, a deeper-dive resource. CTAs sit at conclusion breakpoints or as inline cards near relevant sections. Not a generic "contact us." |
| **What's the internal-link path?** | From this article to the canonical solution page (`/solutions/kubernetes-consulting/` or `/solutions/ai-infrastructure/`), to a city page if the article is locally-scoped, and to one related article in the cluster. |

An article that doesn't answer all five fails the conversion lens and goes back for revision.

## What we never write

- **Boilerplate that ranks but doesn't persuade.** A 1,500-word article on "What is Kubernetes" written for SEO is not a THNKBIG article.
- **"10 options, you decide" articles.** Pick the option. Show the reasoning.
- **Walls of technical detail without the cost / compliance / CTA arc.** Technical depth is necessary; depth without business context is a tutorial, not a THNKBIG article.
- **City pages with thin content + LocalBusiness schema only.** Local proof points (regional case study, customer reference, regional compliance win, local ROI math) are required.
- **Decay fixes that patch the symptom but not the conversion gap.** If form_start drops, the fix is not a meta-tag refresh — it's a CTA audit.

## ICP and compliance vocabulary — canonical

- **Company name:** THNKBIG (all-caps). Never ThnkBIG, ThinkBIG, ThinkBig.
- **ICP:** C-level + VP at regulated enterprises (financial services, defense, healthcare, energy) doing VMware → Kubernetes migrations, AND VPs planning AI initiatives hitting the demo→production gap.
- **Compliance vocabulary:** FedRAMP, IL-4/IL-5, GovCloud, HIPAA, SOC 2, PCI-DSS, NIST 800-53, CMMC, ITAR. Used correctly.
- **Forbidden client names:** Five9, Clearbridge, AHEAD. Substitute: "a Nasdaq-listed cloud contact center SaaS vendor (top-5 in segment)" if a comparable proof point is needed.
- **Phone:** (512) 706-9553. **Address:** 14205 N Mopac Expy, 5th Floor, Austin, TX 78728.

## THNKBIG application

Echo loads this skill together with `inboundsquare-anatomy` and `b2b-tech-marketing` for every draft. Editor checks the conversion-lens table on every review. Vision validates the ICP and proof anchors before queuing a brief.

When the article passes both the Inbound Square compliance bar (article anatomy + unslop) and the THNKBIG voice bar (this skill), it ships.

---

## Provenance

- Primary sources (4 Inbound Square docx, text-extracted 2026-08-28):
  - `Author Guidelines` — engineer-to-engineer bar, AI-use policy, writing-as-teaching ethos.
  - `Anatomy of the Ideal Inbound Square Article` — voice and tone, tense, second-person preference, summary-table discipline.
  - `Inbound Square Style Guide` — formatting mechanics that anchor the voice (sentence case, plain language, no fluff).
  - `Examples of Articles with a Technical Voice` — the engineer-to-engineer exemplars that the THNKBIG layer extends.
- Cross-reference: `GUIDES/service-catalog.md` (canonical ICP, Tier 1/2/3 services, compliance vocabulary); `RESEARCH/SEO_CONTENT_STRATEGY_2026-08-28.md` (conversion lens origin, thread root `ccbf211a8b2289eb14816d0c7010e4ed838fd366982427a89bffb9a7d4f20a7c`).
- Conversion lens source: Rudy directive 2026-08-28 20:36:34Z ("no shortcuts — indepth and breadth — the websites goal is to convert visitors") + Pepper reply 2026-08-28 20:36:58Z (conversion-anchored reframe).
- Author: Pepper.

## Anti-patterns (do not do these)

- Write for "developers looking to upskill" or "anyone interested in cloud native." The reader has signing authority.
- Fence-sit. If the article has no POV, it is not done.
- Cite a number without a case-study source.
- Use a forbidden client name (Five9, Clearbridge, AHEAD) without substituting the generic.
- Use a compliance framework name incorrectly (e.g., "HIPAA-certified" when the artifact is HITRUST, "FedRAMP-authorized" when the engagement is GovCloud-only).
- Ship an article without answering all five conversion-lens questions.
- Let a CTA be "contact us for more information." The CTA names the next step (assessment, deeper dive, discovery call).
- Treat the THNKBIG wedge as optional — Tier 1 services are the wedge; Tier 2 is supporting context.

## Verification rules

- The body matches the four Inbound Square source docs at the versions referenced above. No verbatim copy beyond short, attributed paraphrases.
- The conversion lens table matches the canonical form in `RESEARCH/SEO_CONTENT_STRATEGY_2026-08-28.md` (Rudy reframe thread).
- The ICP and compliance vocabulary match `GUIDES/service-catalog.md`.
- The skill body fits on one screen for casual reference.
- The skill does not contradict any other skill in this library (especially `unslop`, `inboundsquare-anatomy`, `b2b-tech-marketing`, `local-seo-austin-texas`).
