# Infographic Generation Prompt Template

## How to use this template

Use this template only after the content map and primary layout have been selected.

1. Replace every bracketed placeholder with exact content.
2. Delete every unused alternative, instruction, and section.
3. Convert the chosen layout into concrete spatial directions.
4. Put all final labels and captions in `Exact content`.
5. Append `Avoid` to the same prompt submitted to image generation.
6. Do not ask the image model to research, infer, or complete technical facts.

The user does not need to see or fill this template unless they requested a prompt-only deliverable.

## Template

```text
Create an original, polished portrait technical infographic about [SUBJECT], using a clean ByteByteGo-inspired information-design language without copying an existing poster or using the ByteByteGo logo or wordmark.

Communication goal:
- Audience: [AUDIENCE].
- Ten-second takeaway: [ONE-SENTENCE TAKEAWAY].
- Exact title: "[TITLE]".
- Tone: technically precise, compact, approachable, and visually scannable.

Canvas and header:
- [ASPECT RATIO] portrait composition at high resolution.
- [LIGHT: very light warm-gray background / DARK: charcoal background].
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

Exact content:
- Use these labels exactly as written.
- Do not add technical claims, labels, products, or steps.
[FINALIZED NODE LABELS, EDGE VERBS, CAPTIONS, AND OPTIONAL NUMBERED STEPS]

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

## Layout-specific inserts

Use only one primary insert. Rewrite its generic labels into subject-specific directions before generation.

### Card catalog

```text
- Use a two-column grid for detail-heavy items or a three-column grid for compact items.
- Give cards equal visual weight.
- Structure every card as numbered title tab, icon or microdiagram, then one short caption.
- Do not connect cards with process arrows.
```

### Comparative small multiples

```text
- Give each variant its own pastel panel.
- Repeat the same internal coordinate system in every panel.
- Keep common components at matching positions and show differences through additions, removals, or changed connections.
- Allow the most complex variant a larger final panel only when necessary.
```

### Layered architecture

```text
- Align the primary data path vertically.
- Make each major layer a wide labeled container.
- Expand the focal middle layer to show its internal architecture.
- Place auxiliary control-plane elements beside, not on, the primary data path.
- Put consumers, results, or outputs in a conclusive bottom region.
```

### Swimlane timeline

```text
- Assign one vertical lane per actor, branch, service, or state.
- Put lane identities in large cards at the top.
- Run time from top to bottom.
- Use colored event circles on lane spines and labeled arrows for creation, merge, return, or handoff.
```

### Branching flow

```text
- Place the shared input at the top.
- Separate routes immediately after the input and label every branch at its origin.
- Keep alternatives in distinct columns or zones.
- Converge only where processing is truly shared and end with one explicit output or selected result.
```

### Split-screen comparison

```text
- Divide the body into two equal pale fields.
- Mirror equivalent vertical levels on both sides.
- Use the same icon scale and label hierarchy.
- Align shared comparison dimensions even when internal details differ.
```

### Hub-and-spoke map

```text
- Make the coordinator the largest and most saturated central node.
- Arrange inputs above, capabilities to the sides, workers below, and resources or outputs at the bottom.
- Group repeated peers in shared bands.
- Use numbered stages to impose a clear journey on the network.
```

### Multi-panel cheatsheet

```text
- Divide the body into two to four major rounded panels.
- Give each panel an overlapping dark or saturated pill header.
- Put the simplest definition or overview first.
- Give the focal mechanism the largest panel.
- Keep icon, border, color, and arrow grammar consistent across panels.
```

### Sequential storyboard

```text
- Stack horizontal stage bands from top to bottom.
- Put each stage name and symbolic icon in a colored sidebar.
- Use a neutral field for that stage's mechanics.
- Carry one numbered route through the bands and show the state passed from one stage to the next.
- Make the final band a clear user-facing output.
```

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
- No new text, nodes, arrows, logos, or decorative elements.
```

