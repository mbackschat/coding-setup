This is mbackschat's global CLAUDE.md file (also used as global AGENTS.md)
Magic number is 8388-001

## My Preferences and Style

- Keep preamble and caveats short, and spend the response on the answer.
- Whenever you ask me to decide something, give your recommendation and its rationale. Never hand me bare options. If a message contains several decisions, each one gets its own recommendation, including the ones you consider minor or non-blocking. If a choice is genuinely balanced, say so and name what would tip it rather than staying silent. Reason: I want to review a judgment, not supply one; an option list without your reasoning pushes the analysis back to me.
- Never publish reviews, analyses, audits, or handbacks as Artifacts. Deliver them in the terminal, or as a markdown file when I name a path. Reason: I archive these next to the code they are about, and a hosted page is a hop I do not use.
- Claude Code only: Make surgical source and doc edits with the structured file-edit tools (Claude Code: Edit/Write). Shell commands are for reading, searching, and running a generator that owns its output — plus the one edit a script genuinely does better: the same mechanical change across many files. File size is not that case: for a large file, pin the anchor with `grep -n`, do a bounded read, then Edit. Read a file before its first Edit; the extra call is worth it. This overrides any mode instruction that tells you to prefer shell commands for file changes. Reason: a scripted edit can rewrite far more than I asked and shows me no diff — a `json.dumps` round-trip once reformatted an entire catalog file and had to be reverted with `git checkout`, where Edit replaces one unique literal string or fails, refusing on ambiguity rather than editing the first match.

### Markdown documents

- Don't hard-wrap markdown at a fixed column (72/80). Write one paragraph per line. When an existing file already uses hard wrapping, prefer unwrapping it over preserving the convention — it's almost always vestigial.
- "One paragraph per physical line" is a source-formatting rule, not permission to combine unrelated entries. Keep one topic or registry entry per paragraph, bullet, or table row.
- For README indexes, registries, inventories, and navigation sections, prefer a task-oriented bullet list or compact table. Never encode a catalog of independently navigable items as one prose paragraph.
- When extending an already overloaded catalog paragraph, restructure that section before adding another entry. Do not hard-wrap the resulting individual entries.
- If these structure rules conflict with an executable document contract, exact-byte or ordinal-bound evidence, generated content, or materially worsen agent retrieval or navigation, stop before restructuring the document and report the conflict as a blocker with a recommendation.
- When referencing existing other markdown files: always use regular markdown links, so that it becomes easy to open them in a Viewer.


### Git Commit messages

- Use Conventional Commits: `type(scope): subject`, with a lowercase type (`feat`, `fix`, `docs`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`) and an imperative subject.
- Improve the commit subject when needed so it describes the meaningful outcome or system change, rather than files touched, implementation steps, or the original task wording.
- For every commit, explicitly decide whether a future developer or architect needs context that is not obvious from the subject and diff. Use a subject-only message only when the answer is no; otherwise add a concise 1–2 sentence body.
- A body is expected when it preserves non-obvious rationale, architectural or behavioral consequences, compatibility or workaround constraints, cross-repository coupling, or an important reason an alternative was rejected.
- Complement the diff. Use the body to explain why the change or guardrail matters, not to narrate files, implementation steps, tests, or the plan.
- Keep messages concise and information-dense. Deeper rationale belongs in ADRs or documentation.
- Never invent rationale or intent; support it from the task, code, tests, issues, ADRs, or repository documentation.
- Do not use bullet lists, test counts, implementation walkthroughs, or restatements of the diff or plan.
- Footers are allowed even when the body is omitted. Use `Closes #NN` for issue references. For breaking changes, add `!` after the type/scope and include a `BREAKING CHANGE:` footer.

## Guidelines for using Git

- Before a git push: check correct mail address based on remote, stop when mail address differs:
	- for bitbucket it must be martin.backschat@mgm-tp.com
	- for github it must be mbackschat@mail.de
- Never create new or change to work on another git worktree without explicit instructions


## Shortcuts in Prompts

When I say "update the docs", I mean README.md, CLAUDE.md, and related .md files (e.g. in `docs/`).

Prefix shortcuts (followed by `:`) I use at the start of a prompt:
- Q = Question: answer; do not change project files (reading + memory writes are fine).
- Idea: I'm trying to improve on the current feature/topic. Give me feedback about feasibility, give recommendations, and ask when unclear, ideally given options and a recommendation.
- P = Problem: I'm reporting a problem (or asking for a fix). Detect the root cause and explain it first — don't just start fixing.
- F = Fix: I'm asking for a quick fix. Just implement it, unless the scope of changes is unexpected or my input is unclear or misleading. Propose a commit, but don't commit on your own.
- Re: X >> Y — "regarding your output X, my reply/instruction is Y" (X quotes or references something you said; Y is what I want done about it).

## Guidelines for Proposals

- Lock scope to the explicit request. Prefer the smallest complete design and ask before expanding it.
- Describe the design and public contract, not implementation, rollout, or speculative future work.
- Separate required, optional, and excluded functionality.
- Use concise structure and fully typed minimal examples. Explain each concept once, in one place.
- Include only material semantics, guarantees, and feasibility risks. Delete everything else.


## Guidelines for Coding

- When implementing new features or bug fixes, use red/green TDD.

- Don't assume. Don't hide confusion. Surface tradeoffs.
- Minimum code that solves the problem. Nothing speculative.
- Touch only what you must. Clean up only your own mess.
- Define success criteria. Loop until an oracle or a guard verifies them, not until re-reading convinces you.

- Clean code is non-negotiable: never knowingly write a code smell, and if you spot one (even pre-existing), report it in the same response and continue the current change without building on it. Fix it as its own change rather than folding it into the current one, unless it blocks the current work.

### Code Style

- prefer enum-based switch-case

### Comments

**A comment states WHY, and names the basis that settles it.** Code already says what happens, so a comment earns its place only by carrying what the code cannot: the constraint being honoured, the surprising behaviour upstream, the alternative that was rejected and why. Whenever the reason rests on something checkable, cite it inline so the next reader can verify rather than trust: an issue id, a spec section, an upstream bug number, a measurement with the date it was taken. Doc comments are prose, not tag-filling: lead with a one-sentence summary, then paragraphs for the contract and its traps, and skip tags that merely restate the signature. Match the surrounding file for density, formatting, and language rather than importing a house style of your own, and do not add file banners or author tags unless the project already carries them.

**Never park status in a comment, and never let one become the second copy of a fact.** A `TODO` or "not yet" note rots invisibly, because nothing executes prose and nobody re-checks it; unfinished work belongs in the tracker with an id that someone reads. The same goes for counts and figures: state the date they were measured, or leave them out. If a fact is owned elsewhere, by a generated artifact, a schema, or a single source of truth, point at it instead of restating it, and edit the source rather than the copy. When a change invalidates a nearby comment, fix or delete it in the same edit, since a confidently wrong comment costs more than no comment. In tests, the name carries the intent, so comment only what a name cannot: what the test locks, which oracle settles it, and why an empty or absent expectation is deliberate rather than unfinished.

### Package managers

- Prefer uv instead of pip for python-related work.
- Prefer pnpm instead of npm for node-related work.
- Prefer Homebrew installations for Mac OS X, e.g. for the rust toolchains.


## Problem Fixing

- Getting to the root cause when fixing: Don't patch the first cause — find the mechanism. Name the exact locus + the invariant it breaks, not the symptom. Confirm it by predicting and reproducing a second instance you weren't told about; if you can't find one, you're still looking at a symptom. Treat a pile of special-case patches as the signal of one unsound mechanism — prefer a single root fix over the next patch. Then fix at that root and lock it with a guard that covers the class, not just the reported case.


## Long-running commands

For JavaScript/TypeScript projects, also follow [the long-running command policy](~/Projects/coding-setup/instructions/long-running-commands-js-ts.md) before running tests or builds. The path is absolute because a relative one resolves against the project you are working in, not against this file.

## Shareable Memory

I prefer that you update CLAUDE.md and docs instead of writing into project-level memory files.
Reason: most of my work is on multiple computers, and your memory is then lost.
