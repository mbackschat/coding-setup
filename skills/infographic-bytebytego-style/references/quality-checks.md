# Acceptance checks

Use this checklist after generation and after every edit. A prompt instruction is not evidence that the rendered image followed it.

## Hard acceptance gates

| Gate | Required observation |
|---|---|
| Content and evidence | Visible claims agree with the content map. Dates, quantities, negations, scope and material status qualifiers remain accurate and attached to their claims. |
| Text fidelity | All intended visible text is present, correctly spelled and legible; no invented, omitted or duplicate labels. Line wrapping may differ without changing words. |
| Relationships | Audit every `source -> verb -> target` against the whole image. No missing or extra semantic edge, shifted verb, false convergence, crossing through text or ambiguous endpoint. Containment must not become causation. |
| Reading and hierarchy | At reduced viewing size, the title, major groups, focal path and output remain recognizable; detail is readable at the intended delivery size. One reading order and layout dominate. |
| Canvas and contrast | Unless transparency was requested, verify a fully opaque background, including header and gutters. Inspect the alpha channel when the viewer shows unexpected darkness or glow; black text over transparent pixels can become unreadable on dark backgrounds. |
| Series consistency | Repeated entities keep their canonical label, icon family and semantic color. Context remains subordinate to the explanation each poster owns. |
| Identity and user constraints | No unauthorized logo, watermark or copied poster. Explicit user requirements remain satisfied. |
| Export | The helper succeeds under the selected [export profile](../SKILL.md#5-export-the-avif-sibling). Record its measured bytes, dimensions and DSSIM. |

A decorative arrow inside an icon is not a semantic edge between diagram nodes. Judge the actual relationship, not the raw number of arrow shapes.

## Text verification with OCR

For generated infographics, use an available OCR capability to extract text from the accepted candidate and compare it with the exact-copy manifest, region by region. Prefer a local tool for local material. If no OCR capability is available, inspect every region visually and record “visual-only; OCR unavailable”; do not install a dependency without authorization or claim OCR passed.

1. Compare after normalizing Unicode representation and whitespace. Account for line wrapping and OCR reading order manually; do not erase differences in digits, signs, negations, dates, product names, punctuation with technical meaning, or status words.
2. Visually resolve every discrepancy against the pixels. OCR can confuse umlauts, split a compound word or misread an otherwise correct label; do not alter correct artwork merely to satisfy OCR.
3. Check for extra and duplicated text as well as missing copy. Correct OCR output alone does not prove that text is readable or attached to the correct object.
4. Record the tool/method, regions checked and material discrepancies resolved. Re-run affected regions after an edit and audit the entire text/relationship manifest for drift.

## Style preferences and tolerable deviations

Keep the flat palette, dark outlines, horizontal type and topology chosen from [the style guide](style-guide.md). Evaluate them separately from factual and structural gates.

A slight incidental gradient, small radius variation or minor icon detail may be accepted when it does not reduce contrast, change semantic color, obscure text, violate an explicit user requirement or break series coherence. Record a material accepted deviation rather than claiming exact style compliance. If the user explicitly requires perfectly flat fills, a gradient is a hard failure.

Avoid regenerating a technically correct image solely to chase imperceptible stylistic uniformity. If a visible deviation weakens the intended reading or series consistency, make a focused correction.

## Iteration and limitations

For hard failures, use the [focused edit pattern](prompt-template.md#iteration-prompt-pattern) and recheck all gates. If repeated edits cannot reliably correct the defect, explain the limitation and identify the best candidate as incomplete rather than claiming acceptance.

Record actual observations, not an invented numerical quality score. For a comparison requested by the user, use the same factual scope and assess old and new images against the same gates; report unchanged or worse outcomes as candidly as improvements.
