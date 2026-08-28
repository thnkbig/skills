---
title: "Inbound Square Article Anatomy — Structure, Voice, and Editorial Process"
tags: [content, article, structure, voice, inbound-square, seo]
status: active
created: 2026-08-28
---

---
name: inboundsquare-anatomy
description: "Article template Echo follows and Editor verifies: short intro + summary table + detail sections + recommendations + short conclusion. Voice rules: engineer-to-engineer, second person, present tense, sentence-case headings, plain language. Editorial process: keyword research → brief → draft → technical review → editorial review → CMS publish → track. Apply when drafting, reviewing, or scoring any THNKBIG article against the Inbound Square compliance bar."
---

# Inbound Square article anatomy

Five sections, in this order. Voice rules apply across all five. The template is the floor; the THNKBIG voice layer is the ceiling.

## Article structure

### 1. Introduction (one to three short paragraphs)

- Define the topic, spell out acronyms, name the scope.
- Hook the reader with one concrete fact or claim that earns the click.
- Set expectations: "In this article, we explain X, Y, and Z."
- No external hyperlinks in the intro; outbound links lose the click.
- Define all key terms — this is what wins the featured snippet.

### 2. Summary table

- One row per main concept or best practice. Two columns: concept, description.
- The summary is not a table of contents; it summarizes what the article says.
- Use imperative ("do this") form for best-practices articles.
- Title the table for the keyword, not generically. "Summary of key phishing simulation concepts," not "Summary of key concepts."
- Keep it short; long tables lose mobile readers before they start.

### 3. Detail sections

- Heading 2 per main concept or best practice. Heading 3 for sub-concepts. Heading 4 rarely.
- Headers should match summary-table rows closely — cohesion between summary and body is what makes readers retain.
- One concept per section; split sections that run long.
- Aim for 1,500–2,000 words total. Up to 3,000 if the topic warrants it. Double that is a sign of off-keyword drift.
- 1–3 diagrams per article (not screenshots, which don't count). Diagrams need captions with a source link in parentheses.
- Tutorials use numbered lists, not bullets. Bullets are for non-sequential items.
- Tables compare items; never use a two-column table where the left column is just a header (use a bullet list instead).
- Introduce every table in the text immediately before it.

### 4. Recommendations or best practices

- Skip this section for concept articles. Best-practices articles skip the section above and put the best practices in the detail sections.
- Best practices are imperative: "Shorten the feedback loop. Integrate testing into the CI/CD pipeline."
- Short best practices go in a bullet list ("Best practice: Description"). Long ones become subsections.

### 5. Conclusion or summary (one to two short paragraphs)

- Past tense, looks back over what the article said.
- No "In conclusion" or "In summary" openers — the heading carries that load.
- No new content; conclusion is recap.
- Ratio guard: if the article is 1,500 words and the conclusion is 300, something has gone wrong.
- The conclusion is a natural place for one client CTA if the body has been free of them.

## Voice and tone

- **Engineer to engineer.** Speak to an engineer a few months or years behind, not to a beginner. Never open with "In the new digital age…" and never explain fundamentals the audience already knows.
- **Second person.** "You implement the container as follows…" — friendly, keeps the reader engaged. First-person plural ("we explain," "we implement") is fine in the intro and tutorial walk-throughs.
- **Present tense.** "In this article, we explain…" not "we will explain." Conclusion may shift to past tense because it looks back.
- **Sentence case in headings.** Not Title Case. "Summary of software engineering best practices," not "Summary of Software Engineering Best Practices."
- **Lowercase prose.** Only proper nouns, product names, acronyms, and GUI element names are capitalized. Networking Protocols in the information industry, not the Information Industry.
- **Plain language.** Short words. "Use," not "utilize." "Help," not "facilitate."
- **No fluff.** Cut "robust," "vital," "essential," "critical," "crucial," "paramount" — overuse makes importance claims impossible to read.
- **No AI tells.** The unslop skill owns the AI-pattern catalog; load it before drafting.
- **Variety, not synonym cycling.** Don't repeat "ensure" 56 times; also don't rotate protagonist / main character / central figure / hero in one paragraph.

## Style mechanics

- US English spelling, grammar, dates (MM/DD/YY), times (HH:MM am/pm), measurements (feet).
- Ampersands look old-fashioned; use "and" unless part of a name.
- No screenshots for code. Use code blocks. Add a one-sentence instruction before each command.
- Code blocks should mention the software version where the command was issued.
- Exclamation marks sparingly — at most one per article, only for warning or strong emphasis.
- Italics only when necessary for emphasis. Bold for UI element names (button names). Avoid underscores.
- One space after a period, not two.
- Single-line headings when possible.
- Tables for row/column data; bullet lists for short non-sequential items; numbered lists for sequences.
- No more than two lists per article — lists-dense writing is tedious.
- IPv4 examples use unassigned blocks (192.0.2.x). Domain examples use .test or .example.
- Brand names: write them the way the owning company does (VMware, Kubernetes, HubSpot).
- US English: periods and commas always inside quotation marks.
- "Do not crop images inside Google Docs" — three times in the source, three times here. Crop externally first.

## Editorial process

1. **Keyword research** — identify target keywords via GSC + DataForSEO SERP.
2. **Brief** — Vision produces brief: problem, audience, structure, target query, ICP framing, city-scope tag, K8s-Consulting / AI-Infra relevance, conversion lens.
3. **Draft** — Echo drafts the article using the brief + the four skills (`b2b-tech-marketing`, `inboundsquare-anatomy`, `thnkbig-voice-style`, `local-seo-austin-texas` for city pages).
4. **Technical review** — Echo self-marks questionable claims for a domain SME (Reed or K8s/AI infra SME).
5. **Editorial review** — Editor validates Inbound Square compliance, voice, ICP fit, conversion lens, schema.
6. **Final touches** — Editor validates format/schema (LocalBusiness for city pages, FAQ schema where applicable, alt text per Vasco decay Pattern 3).
7. **CMS publish** — Editor pushes to thnkbig.com via local API key (opencode-side credentials).
8. **Track** — `depth` scans newly-published page against SERP competitors on next cycle; `skip` monitors CTR; `decay` watches for theft.

---

## Provenance

- Primary sources (4 Inbound Square docx, text-extracted 2026-08-28):
  - `Author Guidelines` — process, audiences, writing objectives, AI-use policy.
  - `Anatomy of the Ideal Inbound Square Article` — article structure, voice rules, summary-table guidance, recommendations and conclusion.
  - `Inbound Square Style Guide` — formatting, code blocks, tables, lists, paragraphs, US English conventions.
  - `Examples of Articles with a Technical Voice` — tone exemplars, the engineer-to-engineer bar.
- Cross-reference: `RESEARCH/SEO_CONTENT_STRATEGY_2026-08-28.md` §5 (Inbound Square principles distilled); `GUIDES/service-catalog.md` (ICP and compliance vocabulary).
- Author: Pepper.

## Anti-patterns (do not do these)

- Open with "In the new digital age" or any equivalent fluffy opener.
- Explain fundamentals the audience already knows (Kubernetes basics in a VPA article; what an LLM is in a fine-tuning article).
- Title-case headings.
- Use a table of contents as the summary table.
- Use screenshots to show code.
- Use "robust," "vital," "essential," "critical," "crucial," "paramount" more than once per article.
- Bring up new content in the conclusion.
- Mix tutorial steps into bullets or bullet items into numbered lists.
- Crop images inside the editor — crop before upload.
- Use British spellings, dates, or measurements.

## Verification rules

- The body matches the four Inbound Square source docs at the versions referenced above. No verbatim copy beyond short, attributed paraphrases.
- The skill body fits on one screen for casual reference; the article template lives in the body, the process lives in the editorial process section.
- The skill does not contradict any other skill in this library (especially `unslop`, `technical-writing`, and `thnkbig-voice-style`).
- The THNKBIG application of the editorial process reflects the canonical agent pipeline (skip/decay/depth + Echo/Editor + Vision).
