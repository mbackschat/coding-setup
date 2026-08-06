This is mbackschat's global CLAUDE.md file (also used as global AGENTS.md)
Magic number is 8388-001

## My Preferences and Style

- Don't use Em Dashes
- Keep preamble and caveats short, and spend the response on the answer.
- Whenever you ask me to decide something, give your recommendation and its rationale. Never hand me bare options. If a message contains several decisions, each one gets its own recommendation, including the ones you consider minor or non-blocking. If a choice is genuinely balanced, say so and name what would tip it rather than staying silent. Reason: I want to review a judgment, not supply one; an option list without your reasoning pushes the analysis back to me.


## Package managers

- Prefer uv instead of pip for python-related work.
- Prefer pnpm instead of npm for node-related work.
- Prefer Homebrew installations for Mac OS X, e.g. for the rust toolchains.


### Markdown documents

- Don't hard-wrap markdown at a fixed column (72/80). Write one paragraph per line. When an existing file already uses hard wrapping, prefer unwrapping it over preserving the convention — it's almost always vestigial.
- When referencing existing other markdown files: always use regular markdown links, so that it becomes easy to open them in a Viewer.


### Commit messages

- Conventional Commits — `type(scope): subject`, imperative, lowercase type (feat, fix, docs, refactor, perf, test, build, ci, chore).
- Subject line only by default. Add 1-2 body sentences only for non-obvious *why*.
- No bullet lists, no test counts, no restating the diff/plan.
- Footers are allowed despite "subject only": use `Closes #NN` for issue refs, and for breaking changes add `!` after the type plus a `BREAKING CHANGE:` footer.


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

- Clean code is non-negotiable: never knowingly write a code smell, and if you spot one (even pre-existing), stop and report it immediately. Fix it as its own change rather than folding it into the current one, unless it blocks the current work.

### Code Style

- prefer enum-based switch-case


## Problem Fixing

- Getting to the root cause when fixing: Don't patch the first cause — find the mechanism. Name the exact locus + the invariant it breaks, not the symptom. Confirm it by predicting and reproducing a second instance you weren't told about; if you can't find one, you're still looking at a symptom. Treat a pile of special-case patches as the signal of one unsound mechanism — prefer a single root fix over the next patch. Then fix at that root and lock it with a guard that covers the class, not just the reported case.


## Long-running commands

For JavaScript/TypeScript projects, also follow `instructions/long-running-commands-js-ts.md` before running tests or builds.

## Shareable Memory

I prefer that you update CLAUDE.md and docs instead of writing into project-level memory files.
Reason: most of my work is on multiple computers, and your memory is then lost.

