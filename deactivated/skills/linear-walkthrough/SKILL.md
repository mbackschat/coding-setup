---
name: linear-walkthrough
description: Create a detailed linear walkthrough of a codebase, explaining how it all works using showboat to build a walkthrough.md file with code snippets and commentary.
argument-hint: [path-to-source]
user-invocable: true
allowed-tools: Read, Grep, Glob, Bash, Agent, Write, Edit
effort: max
---

# Linear Walkthrough

Read the source and then plan a linear walkthrough of the code that explains how it all works in detail.

Then run `showboat --help` to learn showboat - use showboat to create a `walkthrough.md` file in the repo and build the walkthrough in there, using `showboat note` for commentary and `showboat exec` plus `sed` or `grep` or `cat` or whatever you need to include snippets of code you are talking about.

**Syntax highlighting:** All code blocks in the walkthrough MUST have a language identifier for syntax highlighting. Never use generic identifiers like `output` or `text` — always use the actual language. Use short, common identifiers (e.g., `python` not `python3`, `bash` not `shell`, `js` not `javascript`, `ts` not `typescript`, `rb` not `ruby`, `yml` not `yaml`).

**IMPORTANT — fixing showboat's output fences:** `showboat exec` hardcodes `` ```output `` for result blocks. After every `showboat exec` that extracts source code, you MUST fix the last `` ```output `` fence in the walkthrough to the correct language using the Edit tool (replace ```` ```output ```` with ```` ```python ```` etc.). Determine the correct language as follows:
1. Look at the file extension in the command (e.g., `sed -n '10,20p' foo.py` → `python`, `cat main.go` → `go`).
2. If the command doesn't reference a file, look at the file given as the skill argument.
3. If both are unavailable, guess from the output content.

**Markdown quality:**
- Never escape backticks in headings. Write `` ### `func()` — Description `` not `` ### \`func()\` — Description ``.
- Use LaTeX math (`$...$` for inline, `$$...$$` for display) for mathematical expressions, not inline code. For example, write `$y = Wx$` not `` `y = W @ x` ``.

Also explain advanced concepts in the programming language, libraries/frameworks where these concepts are used in the source.

But make sure to not repeat yourself by repeating explanation.

The verbosity of the explanation must depend on:
1. **Relevance** of concept in context
2. **How advanced** it is

Thus: more relevant or more advanced => more verbose explanation.

Also note that programming language concepts are less relevant than heavily used libraries/frameworks.

**Skip explanations for:** pure TypeScript, React, Redux, Java.
