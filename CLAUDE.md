## My Preferences and Style

Prefer uv instead of pip for python-related work.

Don't hard-wrap markdown at a fixed column (72/80). Write one paragraph per line. When an existing file already uses hard wrapping, prefer unwrapping it over preserving the convention — it's almost always vestigial.

Commit messages: subject line only by default. Add 1-2 body sentences only for non-obvious *why*. No bullet lists, no test counts, no restating the diff/plan.

## Shortcuts in Prompts

When I say "update the docs", I mean README.md, CLAUDE.md, and related .md files (e.g. in `docs/`).

Prefix shortcuts (followed by `:`) I use at the start of a prompt:
- Q = Question: answer; do not change project files (reading + memory writes are fine).
- I = Idea: I'm trying to improve on the current feature/topic. Give me feedback about feasibility, give recommendations, and ask when unclear, ideally given options and a recommendation.
- P = Problem: I'm reporting a problem (or asking for a fix). Detect the root cause and explain it first — don't just start fixing.
- F = Fix: I'm asking for a quick. Just implement it, unless the scope of changes is unexpected or my input is unclear or misleading. Propose commit, but don't on your own!!

## Guidelines for Coding

- When implementing new features or bug fixes, use red/green TDD.

- Don’t assume. Don’t hide confusion. Surface tradeoffs.
- Minimum code that solves the problem. Nothing speculative.
- Touch only what you must. Clean up only your own mess.
- Define success criteria. Loop until verified.

