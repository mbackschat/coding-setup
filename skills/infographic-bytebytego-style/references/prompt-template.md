# Infographic Generation Prompt Template

## How to use this template

Use this template only after the content map and primary layout have been selected.

1. Replace every bracketed placeholder with exact content.
2. Delete every unused alternative, instruction, and section.
3. Convert the chosen layout into concrete spatial directions.
4. Put all final labels and captions in `Exact content`.
5. Append `Avoid` to the same prompt submitted to image generation.
6. Do not ask the image model to research, infer, or complete technical facts.

The user need not fill this template. Retain the complete submitted prompt in the local record when required by [the regeneration contract](regeneration-record.md).

## Template

```text
Create an original, polished [ORIENTATION] technical infographic about [SUBJECT], using a clean ByteByteGo-inspired information-design language without copying an existing poster or using the ByteByteGo logo or wordmark.

Communication goal:
- Audience: [AUDIENCE].
- Ten-second takeaway: [ONE-SENTENCE TAKEAWAY].
- Exact title: "[TITLE]".
- Tone: technically precise, compact, approachable, and visually scannable.
[OPTIONAL SERIES ROLE:
- Unique teaching goal: [QUESTION THIS POSTER ALONE ANSWERS].
- Context-only repeated entities: [LIST].
- Zoom source: [PARENT POSTER OR COMPONENT PATH].
]

Canvas and header:
- [ASPECT RATIO] [ORIENTATION] composition at high resolution.
- [LIGHT: very light warm-gray background / DARK: charcoal background].
- Fully opaque canvas, including header, gutters and footer; use transparency only if the user explicitly requested it.
- Large bold sans-serif title at the top left.
- Short mint-green vertical bar immediately left of the title.
- [NO BRAND: leave the opposite header corner clean / USER BRAND: place the supplied user-owned brand asset in the opposite header corner].
- Reserve a clear gap between the header and the diagram body.

Primary information structure:
- Use a [LAYOUT NAME] as the single dominant layout skeleton.
- Primary reading direction: [TOP TO BOTTOM / LEFT TO RIGHT / RADIAL].
- Focal mechanism: [DESCRIPTION].
- Major regions in reading order: [EXACT REGION LIST].
- Final output or conclusion: [DESCRIPTION].
- Secondary microdiagrams may appear only inside [NAMED REGIONS].
- [OPTIONAL SERIES: Keep [REPEATED ENTITIES] in compact context rails or groups; they must remain visibly subordinate to [OWNED MECHANISM].]

Exact content:
- Use these labels exactly as written.
- Do not add technical claims, labels, products, or steps.
[FINALIZED NODE LABELS, EDGE VERBS, CAPTIONS, STATUS QUALIFIERS, AS-OF DATES, AND OPTIONAL NUMBERED STEPS]

Evidence constraints:
- [MATERIAL CLAIM STATUS AND SCOPE TO PRESERVE; OMIT THIS SECTION IF NONE APPLY]
- Do not turn proposed, illustrative, ongoing or announced content into established capability or completed deployment.

Semantic mapping:
[ENTITY] = [ICON OR VISUAL METAPHOR] + [COLOR] + [SHAPE]
[ENTITY] = [ICON OR VISUAL METAPHOR] + [COLOR] + [SHAPE]
[RELATION] = [SOLID OR DASHED] [COLOR] ARROW labeled "[VERB PHRASE]"

Visual language:
- Heavy black or near-black outlines, rounded rectangles, pill labels, simple circular step numbers, and generous gutters.
- Flat, colorful technical icons with consistent dark outlines and no realistic shading.
- Neutral canvas with a mint brand-style accent, three to five pale semantic hues, and one saturated focal color.
- Use pale fills for large grouping fields and stronger fills for contained focal nodes.
- Use solid arrows for direct primary actions.
- Use dashed arrows for indirect, asynchronous, feedback, or routing relationships.
- Use solid containers for concrete systems or stages and dotted containers for logical groups or capability sets.
- Keep equivalent concepts aligned and visually identical wherever they repeat.
- Keep all text horizontal and fully legible.
- Make the final output visually conclusive.

Layout-specific composition:
[PASTE ONLY THE RELEVANT LAYOUT INSTRUCTIONS FROM THE STYLE GUIDE, REWRITTEN FOR THIS SUBJECT]

Avoid:
- No copied ByteByteGo logo, wordmark, watermark, or existing poster composition.
- No photorealistic imagery, 3D icons, gradients, neon glow, glassmorphism, blurred shadows, decorative textures, or generic stock art.
- No tiny paragraphs, illegible text, invented labels, duplicated words, random arrows, unlabeled crossings, ambiguous line endings, excessive nesting, inconsistent icon families, or decorative charts.
```

## Layout-specific composition

Read only the selected pattern under [Diagram patterns](style-guide.md#diagram-patterns), plus a matching [blueprint](style-guide.md#composition-blueprints) if useful. Rewrite that pattern for the subject in the template's layout section; do not copy the entire pattern catalog into the prompt.

## Iteration prompt pattern

When revising a generated image, use a focused delta prompt instead of recompiling the entire creation prompt:

```text
Edit the attached infographic.

Change only:
- [EXACT CORRECTION]
- [EXACT CORRECTION]

Preserve exactly:
- The current canvas, primary layout, palette, icon family, title placement, and all unaffected content.
- [OTHER ELEMENTS THAT MUST NOT DRIFT]

Quality gates:
- [FAILED GATE TO CORRECT]
- Re-audit every declared source -> verb -> target relationship after the edit, including unaffected regions; no shifted label, missing branch, false convergence, duplicate edge, or dangling connector.
- No new text, nodes, arrows, logos, or decorative elements.
```

## Validation and recording

Apply [the acceptance checklist](quality-checks.md) to the rendered image, including all text, evidence qualifiers and relationships after edits. Store the creation and material correction prompts using [the regeneration contract](regeneration-record.md).
