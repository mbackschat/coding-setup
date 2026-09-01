---
name: infographic-bytebytego-style
description: Create or revise technical infographics with ByteByteGo-inspired information design in portrait or landscape formats, including card catalogs, comparisons, flows, architectures, taxonomies, timelines, and storyboards. Use when the user asks for this infographic style or wants a dense technical subject turned into a clear visual. Do not use for unrelated charts, ordinary diagrams, or copies bearing ByteByteGo branding.
---

# ByteByteGo-Style Technical Infographics

Create original technical infographics that use the visual and information-design grammar associated with ByteByteGo while choosing a layout that fits the subject.

Do not reproduce the ByteByteGo logo, wordmark, watermark, or an existing poster. Use the user's brand only when they provide a name or asset. Otherwise omit branding.

## Inputs

Accept an ordinary natural-language request. Do not require the user to fill a form or know diagram terminology.

Only `subject` is required. Infer useful defaults for everything else unless an ambiguity would materially change the technical meaning.

| Field | Requirement | Meaning and default |
|---|---|---|
| `subject` | Required | The concept, system, process, comparison, or feature set to explain. |
| `takeaway` | Optional | What the reader should understand in 10 seconds. Infer it from the request. |
| `facts` or `sources` | Optional | Approved content, notes, links, or files. Treat supplied facts as the content boundary unless the user asks for research. |
| `audience` | Optional | Reader level and role. Default to software engineers with general technical knowledge. |
| `title` | Optional | Exact headline. Draft a concise headline when absent. |
| `must_include` | Optional | Required concepts, entities, steps, comparisons, or labels. |
| `must_exclude` | Optional | Content or visual elements to omit. |
| `layout` | Optional | `auto`, `cards`, `small-multiples`, `layered`, `swimlane`, `branching`, `landscape-branching`, `zoom-lifecycle`, `split-comparison`, `hub-and-spoke`, `cheatsheet`, or `storyboard`. Default to `auto`. |
| `theme` | Optional | `auto`, `light`, or `dark`. Default to light. Use dark for a cohesive agent, orchestration, or network map when it materially improves the composition. |
| `brand` | Optional | User-owned label or supplied logo asset. Default to no brand mark. |
| `aspect_ratio` | Optional | Default to `auto`: prefer 4:5 portrait for vertical catalogs, stacks and storyboards; 3:2 landscape for left-to-right architectures, multi-lane lifecycles and wide comparisons; use 16:9 when the user needs a slide-native composition. Honor an explicit ratio. |
| `deliverable` | Optional | Final image, prompt only, design brief, critique, or edit. Infer from the user's verb. |
| `output` | Optional | Requested filename, format, or location. Return the generated image in conversation when unspecified. |

Example minimal invocation:

```text
Use $infographic-bytebytego-style to create an infographic explaining how a vector database answers a semantic search query.
```

Example constrained invocation:

```text
Use $infographic-bytebytego-style to create a dark 4:5 infographic for senior backend engineers. Show ingestion, embedding, indexing, approximate nearest-neighbor search, metadata filtering, reranking, and the final response. Use a layered architecture with numbered request steps. Do not show vendor logos.
```

## Workflow

### 1. Respect the requested deliverable

- If the user asks for a final infographic, generate or edit the image.
- If the user asks for a prompt or design brief, return that artifact without generating an image.
- If the user asks for analysis or critique, inspect and report without changing the image.

### 2. Establish factual content

Extract the entities, groups, relationships, sequence, alternatives, and repeated concepts from the user's material.

Do not ask an image model to invent technical facts. If necessary facts are absent and the subject is current, niche, or ambiguous, research them with appropriate primary sources or ask one focused question when research cannot resolve the intended scope.

Write each important relationship as `source -> verb -> target`. Use this list to prevent decorative or semantically empty arrows.

### 3. Choose the information topology

Choose one primary layout based on the reader's main question:

| Reader question | Primary layout |
|---|---|
| What concepts or features exist? | Card catalog |
| How do related variants differ internally? | Comparative small multiples |
| How does data move through system layers? | Layered architecture |
| Who does what, and when? | Swimlane timeline |
| Which route is selected under each condition? | Branching flow |
| How do several execution paths relate to one shared contract? | Landscape branching architecture |
| How does one component work inside a larger system? | Landscape zoom-in lifecycle |
| How do two alternatives differ? | Split-screen comparison |
| What does a central coordinator mediate? | Hub-and-spoke map |
| What are the main views of this broad topic? | Multi-panel cheatsheet |
| What changes at each fixed stage? | Sequential storyboard |

Use one primary skeleton for at least 70% of the composition. Secondary microdiagrams may appear inside its regions but must not create a competing global reading order.

Choose orientation from that skeleton rather than treating portrait as part of the visual style. Recompose the grid when changing orientation; do not rotate or stretch a portrait layout into landscape. Use landscape when four or more meaningful stages, peers or lanes must remain comparable on one horizontal axis.

Read [the style guide](references/style-guide.md) when creating a composition from scratch, selecting or mixing layouts, or correcting a weak composition. For a narrow edit that preserves layout, consult it only when style consistency is relevant.

### 4. Build the content map

Before generating, determine:

- One-sentence takeaway.
- Exact title.
- Primary reading direction.
- Three to seven top-level groups.
- Focal mechanism and final output.
- Canonical label, icon, and color for every repeated entity.
- Exact node text, edge verbs, and short captions.
- Which detail can be removed without weakening the takeaway.
- For a poster series: the unique audience question, concepts owned by this poster, context-only repeated entities, and an optional zoom source.

Prefer structural labels and edge verbs over paragraphs. The final poster must support three reading depths: headline, structure, and detail.

### 5. Compile the generation prompt

Read [the generation prompt template](references/prompt-template.md), fill it from the content map, and remove all placeholders, alternatives, and unused instructions.

The template is an internal construction tool, not a form the user must complete. Do not show the compiled prompt unless the user asks for it.

Include finalized copy under `Exact content`. Append the negative constraints to the same image-generation prompt because the image tool accepts one prompt rather than a separate negative-prompt field.

When editing an existing image, preserve everything the user did not ask to change and express the requested differences precisely.

### 6. Generate or edit

Use the available image-generation tool for the final raster image. Supply referenced images through the tool's supported image-input mechanism when editing or when the user provides visual assets.

Do not use the ByteByteGo logo or synthesize a near-copy. If no user brand is supplied, leave the branding area empty and balance the title accordingly.

### 7. Evaluate and iterate

Inspect the result against these gates:

- The takeaway is clear in 10 seconds.
- The title, major groups, focal path, and output survive thumbnail reduction.
- The reading order is unmistakable.
- Every arrow has a clear source, direction, target, and meaning.
- Repeated entities retain identical labels, icons, and colors.
- Text is horizontal, legible, and technically correct.
- No connector crosses text or terminates ambiguously.
- One layout remains visually dominant.
- The result contains no unauthorized logo, watermark, or copied composition.
- After every image edit, re-audit the complete `source -> verb -> target` manifest; layout edits can shift an edge label, drop a branch, or leave a dangling connector outside the edited region.
- In a series or zoom-in, repeated context remains visually subordinate to the mechanism this poster owns.

If a gate fails, edit the generated image with a focused delta prompt. State what must change and what must remain unchanged. Iterate until the gates pass or a real tool limitation prevents a reliable result.

### 8. Deliver and record

Return the final image with a concise note naming the chosen layout. Mention inferred content or unresolved technical uncertainty only when it matters to the user's use of the result.

For an evolving architecture or multi-poster series, maintain an optional regeneration record with three layers: stable communication idea and style; dated current factual input; and generation history containing the compiled prompt, accepted raster, dimensions, and material QA refinements. Do not require this record for a one-off infographic.
