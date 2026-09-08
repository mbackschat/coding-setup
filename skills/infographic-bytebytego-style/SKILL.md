---
name: infographic-bytebytego-style
description: Create or revise technical infographics with ByteByteGo-inspired information design and produce optimized browser-ready AVIF siblings for generated or existing PNGs. Use when the user asks for this infographic style, wants a dense technical subject turned into a clear visual, or asks to convert an existing PNG infographic to AVIF or reduce its browser delivery size. Do not use for unrelated charts, ordinary diagrams, general photo conversion, or copies bearing ByteByteGo branding.
---

# ByteByteGo-Style Technical Infographics

Create original technical infographics using ByteByteGo-inspired information design. Do not reproduce its logo, wordmark, watermark, or an existing poster. Use a supplied user brand only as authorized.

## Inputs and routing

Accept ordinary natural language; only the subject is required. Infer audience, takeaway, title, layout and orientation from the material. Treat supplied facts as the content boundary unless the user requests research.

| Input | Default or contract |
|---|---|
| Audience | Software engineers with general technical knowledge, unless the task identifies another audience. |
| Layout | Select from the reader's question below; use one dominant skeleton. |
| Theme and brand | Light, no brand mark; use dark only when it suits a cohesive system map. |
| Aspect ratio | 4:5 for vertical catalogs or stacks; 3:2 for horizontal architectures, comparisons or lifecycles; 16:9 for slide-native output. Honor explicit dimensions. |
| Required or excluded content | Preserve the user's constraints in the content map and prompt. |
| Output | Final PNG plus same-directory, same-basename AVIF unless the user declines AVIF. Honor named paths. |
| Export profile | `web-compact`. Use `poster` only when explicitly selected by the user; a large image alone does not select it. |
| Regeneration record | Local `INFOGRAPHICS.md` in the project/output root for a series or evolving architecture, unless declined. Honor a named record path; optional for a one-off image. |

- **Final infographic:** follow the workflow below and generate the requested raster.
- **Conversion only:** run the export helper directly; skip content analysis, image generation and a new regeneration record.
- **Prompt or design brief:** provide the requested text without generating an image.
- **Critique:** inspect and report without modifying the image.

## 1. Establish the content map

Before choosing colors, record:

- Audience question and one-sentence takeaway.
- Exact title, three to seven major groups, reading direction, focal mechanism and output.
- Exact node text, captions and edge verbs, plus canonical labels, icons and colors for repeated entities.
- Every meaningful relationship as `source -> verb -> target`; distinguish containment from a directed connection.
- Claim, source locator, source/as-of date, scope and evidence status for material factual statements.
- For a series: the question each poster owns and which repeated entities are context only.

Use these evidence statuses where applicable:

| Status | Meaning and presentation |
|---|---|
| Documented capability or use | Supported within a stated product, edition, release or deployment scope; preserve any source attribution needed to interpret the claim. |
| Ongoing | Started but not established as complete; retain this qualifier next to the claim. |
| Announced or planned | A dated commitment or intention, not delivered availability; retain dates and future wording. |
| Proposal or assessment | The author's architecture, recommendation or suitability judgment; label it as such. |
| Illustrative | An invented teaching example, not a real deployment, law or measurement. |
| Unverified | Insufficient evidence; omit it or show the uncertainty explicitly if it is needed. |

Only put material status distinctions on the poster; keep full source locators in the record. Never turn a manufacturer's claim into independent certification or infer general availability from an announcement. If essential facts are missing, resolve them from appropriate primary sources within the user's scope or ask one focused question. The image model must not invent technical facts.

## 2. Choose topology and visual grammar

| Reader question | Primary layout |
|---|---|
| What concepts or features exist? | Card catalog |
| How do variants differ internally? | Comparative small multiples |
| How does data move through system layers? | Layered architecture |
| Who does what, and when? | Swimlane timeline |
| Which route is selected under each condition? | Branching flow |
| How do execution paths share one contract? | Landscape branching architecture |
| How does one component work inside a larger system? | Landscape zoom-in lifecycle |
| How do two alternatives differ? | Split-screen comparison |
| What does a central coordinator mediate? | Hub-and-spoke map |
| What are the main views of a broad topic? | Multi-panel cheatsheet |
| What changes at each fixed stage? | Sequential storyboard |

Let one skeleton control at least 70% of the composition. Choose orientation from its relationships: four or more comparable horizontal stages or lanes usually need landscape. Recompose when changing orientation; do not rotate or stretch an existing layout.

For a new composition, read the shared visual grammar and the matching layout section in [the style guide](references/style-guide.md). Load mixing, series, dark-theme guidance or blueprints only when relevant. A narrow edit can preserve the existing grammar without rereading all layouts.

## 3. Compile and generate

Read [the prompt template](references/prompt-template.md). Fill it from the content map, include only the selected layout instructions, and remove unused placeholders and alternatives. Keep exact visible copy separate from layout directions; preserve evidence qualifiers in the copy.

Use the available image-generation tool for the final raster. For edits, load the reference through the tool's supported image-input mechanism and state precise changes and invariants. Preserve everything the user did not ask to change.

The compiled prompt is internal during generation; include it in the regeneration record when one is required. Do not dump it into chat unless requested.

## 4. Validate the PNG

Use [the acceptance checklist](references/quality-checks.md) as the single acceptance authority. It covers exact text comparison with OCR-assisted review, evidence status, full relationship audits, reduced-size reading, and the distinction between hard failures and tolerable style deviations.

Correct hard failures with a focused edit prompt, then recheck the complete poster, including unchanged text and connectors. Preserve the accepted PNG as the archival master.

## 5. Export the AVIF sibling

Run [the PNG-to-AVIF helper](scripts/png-to-avif) on each accepted PNG unless the user requests PNG-only:

```sh
/path/to/infographic-bytebytego-style/scripts/png-to-avif path/to/infographic.png
```

| Profile | File-size limit | Shared quality contract |
|---|---|---|
| `web-compact` (default) | 150,000 bytes | Unchanged dimensions; quality 55, speed 0, YUV444; successful decode; DSSIM ≤ 0.006. |
| `poster` (explicit selection) | No byte ceiling | Same quality contract; larger output is allowed, never implicit downscaling. |

For explicitly requested poster export:

```sh
/path/to/infographic-bytebytego-style/scripts/png-to-avif --profile poster path/to/infographic.png
```

An optional second positional argument sets the output path. Existing AVIFs are protected. Use `--force` only when this task deliberately replaces the corresponding PNG or AVIF and the sibling is known to be stale.

The helper fails rather than weakening the selected profile. Do not silently switch profiles after a failure. Report missing `avifenc`, `avifdec` or ImageMagick `magick` instead of installing dependencies without authorization.

Re-encoding does not retain the PNG's embedded C2PA manifest. Keep the PNG and mention derivative provenance only when relevant to the user's use.

## 6. Deliver and record

For a series or evolving architecture, create or update the local record using [the regeneration contract](references/regeneration-record.md), unless the user declines it. Preserve existing unrelated entries. A named record requested by the user is required even for a one-off image. Do not publish it as a hosted artifact.

Return links to the final PNGs, AVIFs and required record, with a concise note about layout and any unresolved limitations. For conversion-only requests, report exact bytes and DSSIM. Never claim checks that were not performed.
