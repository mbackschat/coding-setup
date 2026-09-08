# Local regeneration record

For a series or evolving architecture, maintain `INFOGRAPHICS.md` in the project/output root unless the user declines it. Honor a named destination. For a one-off image the record is optional unless requested. This is a local source document, not a hosted review or artifact.

Use one paragraph per physical line, ordinary Markdown links to sources and outputs, and one item per bullet or table row. Read an existing record before editing and retain unrelated material.

## Three ownership layers

### Stable communication and design

Record the audience, the unique question and takeaway of each poster, chosen layout/orientation, focal mechanism, context-only repeated entities, canonical colors/icons/labels and durable exclusions. Use a compact table linking each PNG and AVIF. Record explicit user constraints such as filenames, brand or exact dimensions.

### Dated factual input

Record the as-of date, source links and section/page locators. Maintain a compact claim map with evidence status and material scope:

| Claim or group | Source and locator | Source/as-of date | Evidence status | Scope or qualifier |
|---|---|---|---|---|
| The factual statement used in the image | A linked document and its relevant section | The applicable dates | A status from the [content-map contract](../SKILL.md#1-establish-the-content-map) | Product, edition, deployment, illustrative context or other material limit |

Distinguish supplied research from independently checked sources. Do not silently refresh dated claims during regeneration. Identify illustrative, future, proposed and unverified content so later generators cannot promote it to fact.

### Generation and acceptance history

For each accepted image, retain:

- Complete submitted creation prompt, including finalized copy and layout instructions. Do not leave dependencies on “same style as above” or unresolved placeholders.
- Every material correction prompt and the precise reference image(s) used; preserve needed references locally unless the user forbids extra files.
- Tool/mode and model/seed only when actually exposed; original generation versus editing.
- Accepted local PNG/AVIF links, dimensions, generation date and hashes identifying the accepted files.
- Export profile, exact helper invocation, measured bytes and DSSIM.
- Text-check method, factual/status and relationship audit results, corrections, accepted style deviations and unresolved limitations.

When overwriting outputs, update the current-file links, hashes and measurements. Preserve useful earlier prompt/history entries without presenting obsolete measurements as current. If the user requests a comparison, record concrete differences under the same acceptance gates.

## Reproduction contract

State that generative image tools do not guarantee pixel-identical output from the same prompt. Prompts reproduce communication intent and content; archived accepted PNGs preserve exact pixels. Never invent a model version, seed or guarantee.

Provide regeneration steps that use the recorded prompts and reference images, then apply the [acceptance checks](quality-checks.md) and the chosen [export profile](../SKILL.md#5-export-the-avif-sibling). Explain that `--force` is appropriate only when deliberately replacing an existing AVIF.

Update the narrowest layer that owns a change: a corrected factual date does not require rewriting the communication goal, and an export change does not change the image's evidence status.
