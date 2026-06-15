## My Preferences and Style

Prefer uv instead of pip for python-related work.

Prefer pnpm instead of npm for node-related work.

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

## Guidelines for Coding

- When implementing new features or bug fixes, use red/green TDD.

- Don't assume. Don't hide confusion. Surface tradeoffs.
- Minimum code that solves the problem. Nothing speculative.
- Touch only what you must. Clean up only your own mess.
- Define success criteria. Loop until verified.

- Clean code is non-negotiable — never knowingly write a code smell, and if you spot one (even pre-existing), stop, report it immediately, and provide the fix.

## Long-running commands

For JavaScript/TypeScript projects, also follow `instructions/long-running-commands-js-ts.md` before running tests or builds.

## Shareable Memory

I prefer that you update CLAUDE.md and docs instead of writing into project-level memory files.
Reason: most of my work is on multiple computers, and your memory is then lost.