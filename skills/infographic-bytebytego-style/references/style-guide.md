# ByteByteGo-Inspired Infographic Style Guide

## Purpose

Use this guide to create original technical infographics with a ByteByteGo-inspired visual and information-design grammar. It describes layout selection, composition, visual tokens, mixing rules, and validation. It is not an official brand specification.

## Core principle

This style is not one diagram template. It is a stable visual grammar applied to the information topology of the subject.

The stable grammar is:

- Topology-driven canvas: commonly 4:5 portrait, with 3:2 or 16:9 landscape when horizontal comparison, branching, or lifecycle structure requires it.
- Large, direct headline at the top, normally left aligned.
- Short mint-green vertical accent bar at the far left of the headline.
- Optional user-owned brand mark in the opposite top corner.
- Off-white or very light gray background, with an occasional charcoal dark variant.
- Heavy black or near-black type and outlines.
- Rounded containers, pills, tabs, and boxes.
- Flat, colorful technical icons with dark outlines.
- Pastel category fills plus a few saturated accents.
- Short labels, minimal prose, and explicit arrows.
- Clear nesting from poster to section to group to node.
- A reading order that works at thumbnail scale before details are read.

The variable grammar is the body layout. Choose it from the subject's relationships:

| Information shape | Recommended primary diagram |
|---|---|
| Independent concepts of similar importance | Numbered card catalog |
| Several variants sharing the same internal mechanism | Comparative small multiples |
| One system with ordered layers | Layered architecture stack |
| One process with actors or branches over time | Swimlane or branching flow |
| One contract feeding several comparable execution paths | Landscape branching architecture |
| One subsystem opened from a broader architecture | Landscape zoom-in lifecycle |
| Two alternatives readers must contrast | Split-screen comparison |
| One hub coordinating many tools or agents | Hub-and-spoke architecture |
| One topic needing overview plus several deep dives | Multi-panel cheatsheet |
| A fixed sequence with changing context at each stage | Horizontal storyboard bands |

Choose one primary skeleton for the poster. Secondary diagram types may appear inside its regions, but they must support the primary reading order rather than compete with it.

## Canvas and global grid

Recommended defaults:

- Portrait working master: 2400 × 3000 px; lightweight export: 1200 × 1500 px.
- Landscape working master: 3000 × 2000 px; lightweight export: 1536 × 1024 px.
- Use 4:5 portrait for vertical catalogs, layered stacks and top-to-bottom storyboards.
- Use 3:2 landscape for four-or-more-stage left-to-right architectures, multi-lane lifecycles, wide comparisons and zoomed subsystem views with context rails.
- Use 16:9 landscape when the user needs a slide-native asset and the content remains legible at presentation scale.
- Use a taller 10:13 canvas only when a layered system or long timeline genuinely needs more vertical depth.
- Keep the outer safe area around 2.5% to 4% of canvas width.
- Reserve roughly 7% to 11% of canvas height for the title area.
- Use gutters around 1% to 2% of canvas width between major regions.

Choose orientation after modeling the relationships. Recompose the grid when orientation changes; do not rotate or stretch a portrait arrangement into landscape. The canvas should read as one bounded composition. Avoid placing key nodes against the edge or allowing arrows to terminate ambiguously at the crop.

## Header system

The default header is the strongest visual signature:

1. Place a mint vertical bar near the left edge.
2. Place a large, bold title immediately to its right.
3. Keep the title to one or two lines.
4. If the user provides an authorized brand mark, place it at the upper right and align it visually with the title.
5. Leave a clear gap between the title block and the first diagram region.

When no brand is supplied, leave the opposite corner clean or rebalance the title width. Never insert the ByteByteGo logo, wordmark, or a lookalike.

Use selective title highlighting when one phrase carries the topic. A saturated rectangular or rounded highlight may sit behind that phrase, usually purple, magenta, or green, with white text. Highlight one phrase only.

For a balanced `A vs B` infographic, center the two named pills around `VS`. This is the main exception to the default left-aligned headline.

Suggested proportions for a 2400 px-wide master:

- Accent bar: 18 to 28 px wide, 90 to 145 px tall.
- Title: 92 to 132 px, heavy weight.
- Optional brand block: about 330 to 470 px wide.
- Header side padding: 55 to 95 px.

## Typography

Use a friendly geometric or neo-grotesque sans-serif such as Inter, Arial, Helvetica, or a similarly neutral rounded sans.

| Role | Weight | Relative size | Copy limit |
|---|---|---:|---|
| Poster title | 700 to 800 | 4.0% to 5.5% of canvas width | 4 to 10 words, two lines maximum |
| Major section title | 700 | 2.0% to 2.8% | 2 to 6 words |
| Card or node title | 600 to 700 | 1.3% to 2.1% | 1 to 5 words |
| Supporting caption | 500 to 600 | 0.8% to 1.2% | Usually 10 to 22 words |
| Arrow or edge label | 500 to 600 | 0.7% to 1.0% | Prefer a verb phrase of 1 to 4 words |

Keep labels centered inside nodes unless the layout has a strong left-aligned text column. Use sentence case or title case consistently within one level. Avoid long paragraphs. The poster should have three reading depths: headline, structure, and detail.

## Color system

The palette is bright but controlled. Most large areas are neutral or lightly tinted. Saturated colors are reserved for headings, focal nodes, numbered markers, or one semantic category.

Approximate working palette:

| Token | Suggested value | Typical use |
|---|---|---|
| Canvas light | `#F7F7F5` | Main background |
| Canvas gray | `#EEEEEE` | Storyboard bands or secondary field |
| Canvas dark | `#232323` | Dark system map |
| Ink | `#111111` | Text, borders, arrows |
| Dark-mode ink | `#F4F4F4` | Text and connectors on charcoal |
| Mint accent | `#42D3A4` | Headline bar and restrained accent |
| Mint fill | `#96E7B0` | Success, output, environment, or category |
| Cyan fill | `#87DDF2` | Clients, protocols, infrastructure, or category |
| Blue fill | `#64A9F5` | Central services or category |
| Lavender fill | `#C7AEF5` | Planning, alternatives, comparison fields |
| Purple accent | `#7A20F2` | Title highlight or high-level section |
| Pink fill | `#F3A2C1` | Services, events, or category |
| Peach fill | `#FFC48F` | Category or introductory state |
| Yellow fill | `#FFE57A` | Topics, partitions, broker regions, or callout |
| Pale blue field | `#DFF2FF` | Group background |
| Pale green field | `#E3F8E8` | Group background |
| Pale lavender field | `#F0E8FF` | Group background |

Colors are semantic within one poster, not globally fixed. Choose a local mapping, then preserve it throughout that poster.

Color discipline:

- Start with neutral canvas, black ink, mint accent, and three or four semantic colors.
- Add a fifth or sixth color only when categories would otherwise be ambiguous.
- Use pale fills for large regions and stronger fills for contained nodes.
- Keep adjacent regions different in hue or lightness.
- Do not use color as the only distinction. Pair it with position, label, icon, or border treatment.
- Avoid gradients, realistic lighting, glass effects, and photographic textures.

## Shapes, borders, and depth

Use a small, repeated shape vocabulary:

- Rounded rectangles for nodes, cards, stages, and system boundaries.
- Pills for section titles, tags, and compact labels.
- Circles for step numbers, events, and decision markers.
- Dashed rounded rectangles for logical groups or optional capability sets.
- Large pale fields for domains, lanes, or comparison halves.
- Flat icons inside or immediately above labels.

Suggested geometry at 2400 px width:

- Primary outlines: 4 to 7 px.
- Secondary outlines and connectors: 3 to 5 px.
- Main corner radius: 24 to 48 px.
- Compact pill radius: half its height.
- Dashed pattern: short, regular dashes with round or square ends.
- Optional hard offset shadow: 7 to 14 px downward, black or near-black.

Use the hard offset shadow under header tabs or category cards only. Avoid blurred shadows.

## Icons and illustrations

Use flat, colorful, friendly technical icons with dark navy or black outlines, two to five fill colors, simplified geometry, and no realistic shading.

- One visual metaphor per concept.
- Repeat the same icon for the same entity across the poster.
- Keep icons within one illustration family when possible.
- Use product logos only for named products or platforms when appropriate and authorized.
- Use a small UI screenshot only when the UI itself is part of the explanation.
- Do not mix photographic imagery, thin monochrome glyphs, 3D renders, and cartoon icons in one poster.

Icons provide pre-attentive recognition, not decoration.

## Arrows and connector semantics

| Visual form | Meaning |
|---|---|
| Solid arrow | Direct action, request, transfer, or primary sequence |
| Dashed arrow | Logical dependency, asynchronous message, feedback, routing alternative, or indirect relation |
| Dotted container | Logical grouping, capability set, cluster, or scope |
| Solid container | Concrete component, stage, system, or physical boundary |
| Numbered circle on route | Required global reading order |
| Small pill on route | Data, event, mode, protocol, or state carried by that edge |

Label important arrows with verbs such as `produce`, `route`, `fetch`, `validate`, `replicate`, or `return response`. A label should state what changes or moves.

Route connectors orthogonally or with gentle curves. Keep arrowheads clear of node borders, avoid unnecessary crossings, and never let an edge pass through a label. When a complex flow must cross, use lane separation or a small bridge gap.

## Information density

The style is dense, but the density is modular. Detail belongs inside bounded regions rather than being spread evenly across the canvas.

Useful content ranges:

- Card catalog: 9 to 12 cards.
- Global process: 5 to 10 numbered stages.
- High-level architecture: 3 to 5 main layers.
- Side-by-side comparison: 2 mirrored halves with 3 to 6 major elements per half.
- Cheatsheet: 2 to 4 major panels, each containing 1 to 3 microdiagrams.
- Taxonomy: 4 to 6 variants, with the most complex variant allowed a larger region.

These are guardrails, not targets. Fewer clearly differentiated elements are better than a full canvas with weak hierarchy.

## Diagram patterns

### Numbered card catalog

Use for independent features, principles, commands, pitfalls, or components with similar importance.

- Use a 2-column grid for detail-heavy items or a 3-column grid for compact items.
- Keep cards equal in size unless one item is explicitly a summary.
- Give each card an overlapping pill or tab with a number and short title.
- Place a compact icon or microdiagram in the middle.
- End with one short explanatory caption.
- Alternate pale card backgrounds and header colors to aid scanning.

Do not use when the concepts form a mandatory sequence. Numbering is an index here, not a process.

### Comparative small multiples

Use when readers need to compare types that share a common internal model.

- Give each type its own pastel panel.
- Reuse the same internal coordinate system across panels.
- Keep common components in the same positions and colors.
- Show differences by adding, removing, or changing one mechanism.
- Let the most complex type span the full width if needed.

Do not use when every variant has unrelated internals.

### Layered architecture stack

Use for systems with a clear upstream-to-downstream flow.

- Align the primary path vertically.
- Make each major layer a wide, labeled container.
- Expand the central layer to show its internal architecture.
- Keep auxiliary control-plane elements to the side.
- Use nested boxes for cluster, partition, subsystem, or boundary relationships.
- Put final consumers or outputs in a conclusive bottom region.

### Swimlane timeline

Use when time, ownership, and handoffs all matter.

- Assign one lane per actor, branch, service, or state.
- Put lane identities in large cards at the top.
- Run time vertically for portrait. In landscape, run time left to right when several actors or handoffs need aligned lanes.
- Use colored event circles on lane spines.
- Connect events with labeled arrows for creation, merge, return, or handoff.
- Add local annotations beside events instead of a detached legend.

### Branching decision or routing flow

Use when one input can take multiple paths according to a condition, mode, policy, or classifier.

- Place the shared input at the top.
- Separate paths by mode or decision immediately after the input.
- Label each path at the branch, not far downstream.
- Keep alternatives visually distinct in columns or zones.
- Converge paths only when they truly share later processing.
- End with one explicit output or clearly selected result.

### Landscape branching architecture

Use when a shared input or contract fans into several execution paths, backends, deployment targets, or evidence roles that must remain comparable.

- Use three to five aligned columns such as input, contract, execution path, backend, and output.
- Keep the shared contract or decision point saturated and visually central.
- Place alternatives in aligned horizontal lanes and make shared state visibly converge on one canonical node.
- Use a shallow full-width footer for evidence, guarantees, tradeoffs, or another comparison that applies to the paths above.
- Put optional or future adapters in a small dashed extension group outside the primary route.
- Do not let the comparison footer become a second global reading order.

### Landscape zoom-in lifecycle

Use for a deep-dive poster that opens one component from a broader architecture while remaining understandable on its own.

- Add a compact breadcrumb naming the source context and the component being opened.
- Give the owned mechanism roughly half or more of the body and the strongest visual weight.
- Keep repeated callers, publication targets, transports, or downstream services in slim context rails or compact groups.
- Preserve component names when owner orientation matters, but keep repeated context below roughly one-third of the body.
- Separate synchronous/local work from asynchronous or external work with distinct lanes.
- End with the mechanism's consequences, state transitions, or invariants rather than repeating the parent architecture's conclusion.

### Split-screen comparison

Use for `A vs B`, tradeoffs, old vs new, protocol comparison, or competing mental models.

- Divide the body into two equal fields with different pale hues.
- Mirror equivalent vertical levels.
- Use the same icon scale and label hierarchy on both sides.
- Put shared comparison dimensions at matching heights.
- Allow internal detail to differ when that difference is the point.

### Hub-and-spoke system map

Use when a coordinator, gateway, router, broker, or agent mediates among several subsystems.

- Make the orchestrator the largest and most saturated central node.
- Arrange inputs above, capability groups to the sides, workers below, and resources or outputs at the bottom.
- Use numbered labels to impose a journey on the network.
- Group repeated peers into a shared band.
- Use dashed connectors for logical orchestration and solid connectors for direct flow.

### Multi-panel cheatsheet

Use when one topic requires distinct explanatory lenses such as definition, anatomy, features, deployment, security, examples, and alternatives.

- Divide the body into two to four major rounded panels.
- Give each panel a dark or saturated pill header overlapping its border.
- Put the simplest definition or overview first.
- Give the most important mechanism the largest panel.
- Use different microdiagram types only when they answer different questions.
- Preserve common icon, color, border, and arrow grammar across panels.

### Sequential storyboard bands

Use when the system passes through fixed stages and each stage has a different local arrangement or context.

- Use horizontal bands stacked from top to bottom.
- Put a short stage name and large symbolic icon in a colored sidebar.
- Use a neutral field for the mechanics of that stage.
- Carry one numbered connector through all bands.
- Show the state created at one stage and consumed at the next.
- Keep the final band visually conclusive with a user-facing output.

## Mixing diagram types

### The 70/30 rule

Let one diagram type control at least 70% of the poster's spatial organization. Use secondary patterns only inside a panel, lane, band, comparison half, or focal subsystem. If two patterns both demand global reading order, split the topic into two infographics.

Valid combinations:

- A multi-panel cheatsheet containing a layered architecture in its largest panel.
- A split-screen comparison containing a compact flow on each side.
- A card catalog containing one microdiagram inside each card.
- A storyboard band containing a mini architecture snapshot for that stage.
- A layered architecture containing a hub-and-spoke arrangement inside its central system layer.
- A landscape branching architecture with one aligned evidence-comparison footer.
- A landscape zoom-in lifecycle with slim context rails and one lower asynchronous lane.

### Overview plus mechanism plus consequence

Use for a broad introductory topic:

1. One-sentence definition and simplest input-to-output sketch.
2. A dominant region for the primary mechanism.
3. A secondary region for security, failure handling, scaling, deployment, or another operational concern.

### Pattern family plus implementation detail

Use for a cheatsheet connecting concepts to concrete tools:

1. Upper region with several compact pattern summaries.
2. Lower region with one or two larger implementation architectures.
3. Shared icons and colors for repeated entities across both levels.

### Stable frame plus progressive complexity

Use for taxonomies where later types extend earlier ones:

1. Repeat a common internal frame.
2. Add one capability per variant.
3. Give the culminating type a larger final panel.

### Central router plus alternative branches

Use when automatic routing and explicit choices coexist:

1. Shared input at the top.
2. Router or classifier near the first branch.
3. Parallel alternative paths.
4. Shared evaluation, safeguard, or output near the bottom.

### Global sequence plus local snapshots

Use when every step changes what is present in the system:

1. A numbered route provides the global order.
2. Each horizontal band shows one local system snapshot.
3. The route enters and leaves each band at the relevant component.

### Coherence rules

- Share one outer grid and one reading direction.
- Reuse the same noun as the same icon, color, and label everywhere.
- Keep border thickness and corner radius consistent across microdiagrams.
- Use global numbering only for one global journey.
- Keep section headers at one hierarchy level and node labels at another.
- Align repeated components even when panels differ internally.
- Let large pale regions organize and saturated nodes attract attention.
- Avoid more than two nested container levels unless hierarchy itself is the topic.
- Prefer labels adjacent to the marks they explain.
- Do not run arrows across panel boundaries unless the whole poster is explicitly one process.

### Poster series and zoom-ins

For a multi-poster series, assign every poster one audience question and one owned explanation. Record which concepts are unique to it and which repeated components are context only.

- Reuse the same canonical label, icon family, and color for an entity throughout the series.
- Repeat a component only when standalone comprehension, component-owner orientation, or the local mechanism requires it.
- Render context-only components smaller, paler, or inside a labeled context rail so they cannot compete with the owned mechanism.
- Use a short zoom-in breadcrumb when a poster opens a subsystem from another poster.
- If two posters explain the same arrows or state transition at equal depth, remove or compress one explanation rather than relying on different titles.
- Preserve historical or evolving factual detail in a regeneration record rather than duplicating it across poster copy.

## Content architecture

Answer these questions before selecting colors or icons:

| Question | Required answer |
|---|---|
| What should a reader understand after 10 seconds? | One sentence. |
| What is the information shape? | Catalog, comparison, sequence, branching flow, layered system, taxonomy, timeline, or hub. |
| Which orientation fits that shape? | Portrait for vertical progression; landscape for horizontal comparison, branching, or aligned lanes. |
| What are the 3 to 7 top-level groups? | Named groups only. |
| What is the primary reading order? | Top-to-bottom, left-to-right, radial, or indexed. |
| Which entities repeat? | One canonical label, icon, and color for each. |
| Which relations require arrows? | Write each as `source -> verb -> target`. |
| What detail can be removed? | Anything that does not support the takeaway. |
| What is the focal mechanism? | The region with the most space and strongest color. |
| If this belongs to a series, what does this poster own? | One unique audience question plus a short list of context-only repeated entities. |

Then build copy in three layers:

1. Headline: the promise or question.
2. Structural labels: sections, stages, systems, types, and nodes.
3. Explanatory detail: edge verbs, short captions, examples, and constraints.

Do not begin with prose and shrink it into boxes. Begin with relationships, then write only the labels needed to make those relationships unambiguous.

## Composition blueprints

### Multi-panel explainer

```text
┌──────────────────────────────────────────┐
│ ▌ TITLE                    OPTIONAL BRAND│
├──────────────────┬───────────────────────┤
│ DEFINITION       │                       │
│ + SIMPLE FLOW    │ PRIMARY MECHANISM     │
├──────────────────┤                       │
│                  ├───────────────────────┤
│ SECONDARY VIEW   │ OPERATIONAL DETAIL    │
│                  │ OR CONSEQUENCE        │
└──────────────────┴───────────────────────┘
```

Make the primary mechanism at least 35% of the body area.

### Card catalog

```text
┌──────────────────────────────────────────┐
│ ▌ TITLE                    OPTIONAL BRAND│
├─────────────┬─────────────┬──────────────┤
│ 1 CARD      │ 2 CARD      │ 3 CARD       │
├─────────────┼─────────────┼──────────────┤
│ 4 CARD      │ 5 CARD      │ 6 CARD       │
├─────────────┼─────────────┼──────────────┤
│ 7 CARD      │ 8 CARD      │ 9 CARD       │
└─────────────┴─────────────┴──────────────┘
```

Repeat the internal sequence `tab -> icon or microdiagram -> caption`.

### Layered system

```text
┌──────────────────────────────────────────┐
│ ▌ TITLE                    OPTIONAL BRAND│
├──────────────────────────────────────────┤
│ INPUTS                                   │
└───────────────────┬──────────────────────┘
                    │ verb
┌───────────────────▼──────────────────────┐
│ SYSTEM BOUNDARY                         │
│ ┌──────────── CENTRAL CLUSTER ─────────┐│
│ │ node       node       node           ││
│ └──────────────────────────────────────┘│
│                         control plane    │
└───────────────────┬──────────────────────┘
                    │ verb
┌───────────────────▼──────────────────────┐
│ OUTPUTS                                  │
└──────────────────────────────────────────┘
```

Make the middle system region dominant. Keep the control plane visibly secondary and off the main axis.

### Split comparison

```text
┌──────────────────────────────────────────┐
│ OPTIONAL BRAND      A  VS  B             │
├────────────────────┬─────────────────────┤
│ A CLIENTS          │ B CLIENTS           │
│        ↕            │        ↕            │
│ A PROTOCOL         │ B PROTOCOL          │
│        ↕            │        ↕            │
│ A SERVER           │ B GATEWAY           │
│        ↕            │       ↙ ↓ ↘         │
│ A RESOURCES        │ B SERVICES          │
└────────────────────┴─────────────────────┘
```

Matching vertical levels matter more than identical internal structures.

### Storyboard process

```text
┌──────────────────────────────────────────┐
│ ▌ TITLE                    OPTIONAL BRAND│
├──────────┬───────────────────────────────┤
│ 1 STAGE  │ local state and step 1       │
├──────────┼───────────────────────────────┤
│ 2 STAGE  │ local state and steps 2-3    │
├──────────┼───────────────────────────────┤
│ 3 STAGE  │ local state and steps 4-5    │
├──────────┼───────────────────────────────┤
│ 4 STAGE  │ local state and steps 6-8    │
├──────────┼───────────────────────────────┤
│ 5 OUTPUT │ result and step 9             │
└──────────┴───────────────────────────────┘
```

The stage labels define semantic chunks. The numbered route defines temporal order.

### Landscape branching architecture

```text
┌────────────────────────────────────────────────────────────────┐
│ ▌ TITLE                                             OPTIONAL BRAND│
├──────────────┬──────────────┬────────────────┬───────────────────┤
│ INPUTS       │ CONTRACT     │ EXECUTION PATHS│ BACKENDS / OUTPUTS│
│ node         │ focal node   │ path A         │ target A          │
│ node ───────▶│      ├──────▶│ path B ───────▶│ target B          │
│ node         │      └──────▶│ path C         │ shared state      │
├──────────────┴──────────────┴────────────────┴───────────────────┤
│ ALIGNED EVIDENCE, GUARANTEES, OR TRADEOFF COMPARISON            │
└────────────────────────────────────────────────────────────────┘
```

Keep the main left-to-right route above the footer. Align each footer item with the path it qualifies.

### Landscape zoom-in lifecycle

```text
┌────────────────────────────────────────────────────────────────┐
│ ▌ TITLE                                                        │
│ ZOOM-IN: PARENT → SUBSYSTEM → OWNED COMPONENT                  │
├───────────┬──────────────────────────────────────┬─────────────┤
│ INPUT     │ DOMINANT OWNED MECHANISM             │ OUTPUT      │
│ CONTEXT ─▶│ state → operation → result           ├────────────▶│
│ RAIL      │ change / evidence / local feedback   │ CONTEXT RAIL│
├───────────┴────────────────────────┬─────────────┴─────────────┤
│ OWNED PLANNING OR STATE TRANSITION │ ASYNC / EXTERNAL CONTEXT  │
├────────────────────────────────────┴───────────────────────────┤
│ CONSEQUENCES, COMPARISON, OR INVARIANTS                        │
└────────────────────────────────────────────────────────────────┘
```

Make the central mechanism visually dominant. Context rails keep the poster standalone without re-teaching the parent architecture.

## Light and dark variants

Use the light variant by default. It supports dense explanatory text, large pastel fields, and multiple diagram families.

Use the dark variant for a single cohesive system map involving agents, orchestration, networks, or an AI-centric architecture.

Dark variant rules:

- Use one charcoal field across the whole poster.
- Set headings and key labels in white or near-white.
- Use light gray dashed connectors.
- Make the focal node saturated blue, purple, or green.
- Use outlined capability groups with dark tinted fills.
- Put icons on subtle circular dark-gray backplates when needed.
- Do not mix dark and light panels unless the contrast has a semantic purpose.

## Quality-control rubric

Score each criterion from 0 to 2. A production-ready poster should score at least 17 out of 20, with no zero.

| Criterion | 0 | 1 | 2 |
|---|---|---|---|
| Ten-second takeaway | Unclear | Partly visible | Immediately clear |
| Diagram selection | Mismatched | Usable | Natural fit for the relationships |
| Reading order | Ambiguous | Mostly clear | Unmistakable |
| Hierarchy | Flat or chaotic | Some hierarchy | Clear title, section, node, and detail levels |
| Connector meaning | Random or crossing | Mostly readable | Consistent, labeled, and unambiguous |
| Semantic consistency | Same entity changes style | Minor drift | Same entity always looks the same |
| Text economy | Paragraph-heavy | Some excess | Compact and precise |
| Color discipline | Decorative or overloaded | Mostly controlled | Semantic and restrained |
| Icon consistency | Mixed visual families | Small inconsistencies | One coherent icon language |
| Reduced-size legibility | Fails when reduced | Main structure survives | Structure and key labels remain readable |

After any image edit, compare the complete relationship manifest with the rendered poster rather than checking only the requested delta. Verify every `source -> verb -> target`, including unaffected regions; remove dangling arrows, duplicate edge labels, shifted verbs, missing branches, and false convergence.

## Common failure modes

- Choosing a familiar layout instead of one that fits the relationships.
- Treating portrait orientation as part of the style identity when the topology needs landscape.
- Treating every concept as equally important.
- Mixing multiple global coordinate systems.
- Using arrows as decoration rather than actions or relations.
- Nesting more containers than the hierarchy requires.
- Writing paragraphs before modeling the structure.
- Changing the style of a repeated entity without a semantic reason.
- Repeating parent-poster context at the same visual weight as a zoom-in's owned mechanism.
- Trusting unaffected connectors after an image edit without re-auditing their source, verb, and target.
- Mixing incompatible icon families.
- Copying a brand or existing composition instead of applying the information-design grammar.

## Final checklist

Before generation:

- [ ] The subject has a one-sentence takeaway.
- [ ] The primary diagram type is named.
- [ ] The orientation follows the relationship topology rather than a fixed format default.
- [ ] One skeleton controls the poster.
- [ ] The focal mechanism has the most visual weight.
- [ ] Repeated entities have canonical labels, colors, and icons.
- [ ] Every required relationship is written as `source -> verb -> target`.
- [ ] Exact copy is finalized.
- [ ] For a series, the poster's unique question and context-only repeated entities are explicit.

Before delivery:

- [ ] The title is readable at thumbnail size.
- [ ] The reading direction is obvious without reading captions.
- [ ] No connector crosses a label or terminates ambiguously.
- [ ] Every `source -> verb -> target` relationship still matches the manifest after the final edit.
- [ ] No connector is dangling, duplicated, falsely converged, or carrying a shifted edge label.
- [ ] Solid and dashed lines have consistent meanings.
- [ ] Large regions use pale fills and focal nodes use stronger fills.
- [ ] Text remains horizontal, legible, and technically correct.
- [ ] Equivalent components align across comparisons or small multiples.
- [ ] In a series or zoom-in, repeated context is visually subordinate to the owned mechanism.
- [ ] The output or takeaway is visually conclusive.
- [ ] The poster works in grayscale.
- [ ] No unauthorized logo, watermark, or copied composition appears.
