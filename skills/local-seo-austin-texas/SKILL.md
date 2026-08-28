---
title: "Local SEO — Austin + Houston + Dallas + San Antonio + Texas"
tags: [seo, local-seo, city-pages, schema, conversion, thnkbig]
status: active
created: 2026-08-28
---

---
name: local-seo-austin-texas
description: "THNKBIG canonical skill for city-page SEO across the Austin (HQ) + Houston + Dallas + San Antonio + Texas state cluster. Loads when reviewing, drafting, or auditing a city-page article or query. Conversion-anchored per the 2026-08-28 goal reframe."
disable-model-invocation: true
---

# Local SEO — Austin + Houston + Dallas + San Antonio + Texas

City-page SEO for the THNKBIG Texas cluster. Conversion-anchored: every city page must make a CFO or VP-Eng at a regulated enterprise with VMware → K8s or AI-infrastructure authority want to book a call after reading.

## When to load

- Reviewing, drafting, or auditing a city-page article (Austin, Houston, Dallas, San Antonio, or Texas state)
- A skip / decay / depth brief surfaces a city-page query
- An Editor review covers a city page
- Skip the skill entirely for non-Texas cities — out of scope per service-catalog.md

## City list (canonical, from GUIDES/service-catalog.md + locations.ts)

| City | State | URL slug | Notes |
|---|---|---|---|
| Austin | TX | `/locations/austin/` | HQ. Meta: "Kubernetes & AI Infrastructure Consulting Austin TX \| THNKBIG" |
| Houston | TX | `/locations/houston/` | Energy + healthcare anchors |
| Dallas | TX | `/locations/dallas/` | Financial services + defense anchors |
| San Antonio | TX | `/locations/san-antonio/` | Defense + cybersecurity anchors |
| Texas | — | `/locations/texas/` | State-level catchall |

## NAP (canonical for every city page)

```
Name: THNKBIG
Address: 14205 N Mopac Expy, 5th Floor, Austin, TX 78728
Phone: (512) 706-9553
```

City pages do NOT have separate street addresses (THNKBIG operates from Austin HQ; cities are service-area pages, not branch offices). NAP must be byte-identical across the page.

## LocalBusiness schema template (every city page, in frontmatter)

```json
{
  "@context": "https://schema.org",
  "@type": "ProfessionalService",
  "name": "THNKBIG",
  "address": {"@type": "PostalAddress", "streetAddress": "14205 N Mopac Expy, 5th Floor", "addressLocality": "Austin", "addressRegion": "TX", "postalCode": "78728", "addressCountry": "US"},
  "telephone": "+1-512-706-9553",
  "url": "https://thnkbig.com/locations/<city-slug>/",
  "areaServed": [{"@type": "City", "name": "<city-name>"}, {"@type": "State", "name": "Texas"}],
  "knowsAbout": ["Kubernetes", "AI Infrastructure", "VMware to Kubernetes Migration", "Platform Engineering", "FinOps"],
  "priceRange": "$$$$"
}
```

Missing `name`, `address`, `telephone`, or `areaServed` for the target city → BLOCK.

## Meta title / meta description / H1 conventions

- **Title:** `Kubernetes & AI Infrastructure Consulting <City> <State> | THNKBIG` — 50-60 chars, keyword in first 30 chars, "THNKBIG" suffix (ALL-CAPS, never other casing).
- **Meta description:** `THNKBIG delivers Kubernetes and AI Infrastructure consulting to <City> enterprises. <proof point>. <CTA hint>.` — 150-160 chars, must include city name + one proof point + CTA hint.
- **H1:** `<City> Kubernetes & AI Infrastructure Consulting` — must NOT be identical to the title tag.

## Internal-link targets (every city page must link to all of these)

- `/solutions/kubernetes-consulting/` — anchor "Kubernetes Consulting"
- `/solutions/ai-infrastructure/` — anchor "AI Infrastructure"
- A conversion page: `/contact/`, `/assessment/`, or a relevant case study
- At least 2 other Texas city pages (anchor "<City> office" or "<City> team")
- `/locations/texas/` — anchor "Texas-wide coverage"

Fewer than 2 Tier 1 `/solutions/` links OR no conversion-page link → REVISE.

## City-vs-national CTR baseline

City SERP CTR runs ~+20% higher than national for equivalent positions. Track SEPARATELY — do not aggregate city + national. Approximate baseline:

| Position | City CTR | National CTR |
|---|---|---|
| 1-3 | 25-35% | 20-30% |
| 4-7 | 10-15% | 8-12% |
| 8-10 | 5-8% | 4-6% |
| 11-20 | 2-4% | 1.5-3% |

Position 5 city page at CTR 5% = click-gap + conversion-gap signal. Load `skip` patterns.

## Per-city local proof requirements (the conversion ceiling)

Every city page must include ≥2 of these 4 categories, **regionally anchored** (not generic THNKBIG proof):

| Category | What it means | Examples by city |
|---|---|---|
| Case study with regional anchor | Case study citing a customer in or near the city | Austin: TX energy/healthcare customer; Houston: oil & gas / utilities; Dallas: financial services / defense; San Antonio: defense / cybersecurity |
| Customer reference in-metro | Named customer in the metro area | Austin-metro / Houston-metro / DFW / South TX |
| Regional compliance win | Compliance credential specific to the region | IL-5 GovCloud (Austin); ERCOT/PUC (Houston); TX DOI (Dallas); CMMC/FedRAMP for TX defense (San Antonio) |
| Local ROI math | Cost-of-living-adjusted ROI for the city | Cost-of-living adjusted savings; regional cost-per-compliance; energy-cost-adjusted GPU spend reduction |

Fewer than 2 categories present per city page → REVISE (Section 7 PERSUASION violation per Editor persona).

## Worked example — Austin city page skeleton

```markdown
---
title: "Kubernetes & AI Infrastructure Consulting Austin TX | THNKBIG"
description: "THNKBIG delivers Kubernetes and AI Infrastructure consulting to Austin enterprises. $850K/yr savings for a Fortune 500 TX energy customer. Talk to an Austin architect."
canonical: "https://thnkbig.com/locations/austin/"
schema: [ProfessionalService as above, areaServed=Austin+TX]
---

# Austin Kubernetes & AI Infrastructure Consulting

[2-paragraph intro: K8s + AI Infra in THNKBIG context. Hook: Austin as HQ.]

[Summary table: "Summary of Kubernetes & AI Infrastructure concepts for Austin enterprises" — 5 rows, imperative form]

## Why Austin enterprises choose THNKBIG
[Multi-angle body: cost (Fortune 500 TX energy customer — $850K/yr savings, 50x deploy freq). Compliance (SOC 2 first-attempt pass for Austin SaaS). Migration path (VMware → K8s in 90 days for IL-5 GovCloud).]

## Local proof — Austin + TX
[≥2 of: case study with regional anchor / customer reference in-metro / regional compliance win / local ROI math.]

## THNKBIG's Austin engagement model
[Assessment → Stabilization → On-Demand Ops.]

[Internal links to all targets in the table above]

## Conclusion + CTA
[Soft CTA mid: "Talk to an Austin architect." Hard CTA end: "Book a 30-min assessment."]
```

## Provenance

- Canonical service + city scope: `GUIDES/service-catalog.md` §City scope (owner: Pepper; updated 2026-08-28)
- City metadata + 16-city dataset: `REPOS/thnkbig.com-astro-seo/src/data/locations.ts`
- Conversion-ceiling requirement: Rudy 2026-08-28 20:36Z (event `38bd6e3c…` — "no shortcuts, depth + breadth, goal is to convert visitors with signing authority")
- City-vs-national CTR uplift baseline: B2B local SEO patterns + Vasco SEO video transcript (`RESEARCH/VASCO_SEO_AGENTS_VIDEO_2026-08-28.md`)
- Editorial review: Editor v2 persona (event `fce8e3e9…`), Section 7 PERSUASION

## Anti-patterns (do not do these)

- City pages with thin content + LocalBusiness schema only (no local proof). Rudy called this out 2026-08-28.
- Generic THNKBIG proof without regional anchoring ("Fortune 500 customer" with no city/state anchor).
- NAP inconsistency (different phone, abbreviated vs. full street name, alternate address formats).
- Title tag missing city or state.
- H1 identical to title tag.
- Internal links to non-Texas locations.
- Schema missing `areaServed` or with wrong target city.
- City page targets a Tier 3 / out-of-scope service.
- Aggregating city + national CTR or position data into one number.

## Verification rules

- City list matches `GUIDES/service-catalog.md` §City scope and `REPOS/thnkbig.com-astro-seo/src/data/locations.ts`. If those diverge, escalate to Pepper.
- NAP is byte-identical to the canonical block above on every city page.
- Meta title ≤ 60 chars; meta description 150-160 chars; H1 ≠ title tag.
- LocalBusiness schema includes `name`, `address`, `telephone`, `areaServed` for the target city.
- ≥2 of the 4 proof categories present per city page, each with a regional anchor.
- Internal-link set includes both Tier 1 `/solutions/` pages AND a conversion page.
- The skill does not contradict any other skill in this library (especially `technical-writing`, `unslop`, `bro`).
- The body fits on a few screens for casual reference (one-screen ideal per the `bro` convention).
