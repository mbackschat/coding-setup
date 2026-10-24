---
name: bkt
description: Work with Bitbucket pull requests from the command line using the bkt CLI, a keychain-authenticated REST fallback, and Jenkins console logs. Use when inspecting a Bitbucket PR, reading or exporting its review comments with file/line context, checking PR build status, or diagnosing a failed PR build.
argument-hint: "[pr-id] [--out FILE]"
---

Bitbucket work from the command line. `bkt` (Homebrew, verified at version 0.31.1) speaks to both Bitbucket Data Center and Cloud. Prefer it over hand-rolled `curl` for PR status, build checks, comments and diffs, but do not assume it is authenticated: it is per-machine state, and an unconfigured machine fails every repo command.

## Preflight, always run this first

```bash
bkt auth status && bkt context list
```

- Both succeed: use the `bkt` commands below.
- Either says `No hosts configured` / `No contexts configured`: `bkt` is installed but unusable on this machine. Do not stall and do not ask the user to authenticate before trying anything. Go to [REST fallback](#rest-fallback-works-without-bkt-auth), which needs no `bkt` setup at all, and mention the one-time setup afterwards.

The failure you will see from an unconfigured machine is `Error: no active context; run 'bkt context use <name>'`, on every subcommand including read-only ones.

## Command surface

Verified against `bkt --help` / `bkt <cmd> --help` at 0.31.1:

- `bkt pr view <id>`: PR details. `bkt pr list --mine`, `bkt pr diff <id>`, `bkt pr checkout <id>`.
- `bkt pr comments <id>`: list comments. `bkt pr comment <id>` writes one.
- `bkt pr checks <id>`: build/CI status for the PR head commit. Aliased `builds`. Flags: `--wait`, `--fail-fast`, `--timeout`, `--web`. Exit codes: 0 all passed, 1 a build failed, 8 timed out with builds pending.
- `bkt status pr <id>`: same statuses through the status command tree (DC only). Also `bkt status commit <sha>`, `bkt status rate-limit`.
- `bkt api <path>`: raw REST for anything without a first-class command, for example `bkt api /rest/api/1.0/projects/PROJ/repos/my-repo/pull-requests/42/activities --param limit=100`. Honors the active context's host.
- Global output flags on most commands: `--json`, `--jq '<expr>'`, `--template`, `--yaml`.

**There is no `bkt pr status`.** Typing it prints the `bkt pr` help **and exits 0**, so it reads as success in a script or an agent loop. Same for any other misspelled subcommand (`bkt pr nonsense 110` also exits 0). Use `bkt pr checks <id>` or `bkt status pr <id>`, and never treat exit 0 alone as proof a `bkt` subcommand exists.

## REST fallback, works without bkt auth

Bitbucket DC REST reached with the credential git already stores for the remote host (macOS keychain). This is the path that works on a machine where `bkt` was never configured:

```bash
HOST=bitbucket.example.com   # from: git remote -v
printf 'protocol=https\nhost=%s\n\n' "$HOST" | GIT_TERMINAL_PROMPT=0 git credential fill
```

Never pass the credential on the command line, where it lands in the process list and shell history. Write a `umask 077` netrc into a temp dir, use `curl --netrc-file`, and delete it with a `trap ... EXIT`. `${CLAUDE_SKILL_DIR}/scripts/pr-comments.sh` does exactly this and is the reference implementation.

`GIT_TERMINAL_PROMPT=0` matters: without it `git credential fill` prompts on the terminal and hangs when nothing is stored. With it, a machine with no stored credential fails fast (`exit 128`) so you can fall back or report.

URL shapes for a DC host, given remote `https://<host>/scm/<project>/<slug>.git`:

- API base: `https://<host>/rest/api/1.0/projects/<PROJECT>/repos/<slug>/pull-requests/<id>`
- Browser/PR URL: `https://<host>/projects/<PROJECT>/repos/<slug>/pull-requests/<id>`, or read `.links.self[0].href` from the PR payload, which carries the canonical project-key casing (the remote URL often has it lowercased).

## Export review comments with full context

```bash
${CLAUDE_SKILL_DIR}/scripts/pr-comments.sh <pr-id> [--commits] [--out FILE] [--repo HOST/PROJECT/SLUG] [--raw FILE] [--stdout]
```

Writes Markdown (default `~/Downloads/pr-<id>-review-comments.md`) and prints a one-line census to stderr: total, anchored, blocker and orphaned comment counts. Per anchored comment it emits file path and line, comment id, author, UTC timestamp, **the commit the comment was written against**, state and severity, the anchor kind (ADDED/CONTEXT line, new vs old file, orphaned), a `?commentId=` deep link, the comment text, the surrounding **diff hunk with real line numbers** and a `<-- COMMENT ANCHORED HERE` marker, then all replies nested by depth. Sorted by file path then line. Non-anchored comments (the CI summary bot, general discussion) go in their own section.

Commit attribution is on by default: a summary table of the distinct heads the comments were written against opens the report, each comment header carries its own head, and a reply is annotated only when the head moved since the comment above it. `--commits` prints just that mapping (summary plus one row per comment and reply) to stdout, without the comment bodies, for when you only need the comment-to-commit lookup.

Everything comes from one endpoint, `pull-requests/<id>/activities`, which is the only place where the comment, its `commentAnchor` and the `diff` hunks arrive together. `bkt pr comments <id>` does not carry the diff context. The script paginates until `isLastPage`, prefers the keychain credential and falls back to `bkt api`, and needs `jq`.

### Which commit a comment was written against

**`commentAnchor.fromHash` / `toHash` do not answer this.** Bitbucket re-anchors every comment onto the PR's *current* effective diff at each rescope, so those two hashes are the same for all comments and can postdate them by days. Measured on a real PR: all 17 anchors carried one identical base and head pair, and that head was committed a day and a half after the last comment was written.

The `RESCOPED` activities are the only record of where the head actually was. Each carries `previousFromHash`/`previousToHash`, `fromHash`/`toHash` and a timestamp; replay them in time order and take the last entry at or before a comment's `createdDate`. The script does this and covers the window before the first rescope with a synthetic entry built from `previousFromHash`, so comments written early in a PR's life still resolve.

Two traps in that data. The naming inverts between the structures: in `RESCOPED`, `fromHash` is the source-branch head and `toHash` the target branch, while in `commentAnchor` `fromHash` is the base side and `toHash` the source head. And the target side only updates when the PR actually rescopes, which can lag a merge into the target branch by an hour or more, so a comment can legitimately record an older base than the merge timeline suggests.

The reconstruction is exact only while history is append-only. A force-push shows up as commits in a rescope's `removed.commits`, and rewritten SHAs may no longer resolve anywhere. Commit subjects are looked up in the local clone as a convenience and are simply omitted when the hash is not present.

Reach for `--repo` when running outside a checkout, and `--raw` when you want the merged activities JSON to query further with `jq`.

Data Center only. Bitbucket Cloud exposes a different API (2.0, workspace-scoped) and this script does not target it.

## Jenkins console logs for a failed build

`bkt pr checks <id>` gives pass/fail and the build URL, not the failure. The CI summary comment on the PR also carries a `console` link. Fetch the log directly:

```bash
grep '^machine' ~/.netrc                                   # confirm the Jenkins host is in there FIRST
curl -fsS --netrc "<build-url>/consoleText" | tail -200
```

Jenkins requires authentication. Without a matching `~/.netrc` entry you get **HTTP 403 and an HTML login-redirect page**, not the log. Use `-f` so curl fails loudly instead of handing you HTML that looks like output; if you see `Authentication required` in the body, the credential is missing, not the build.

Add the entry once (user-supplied API token from the Jenkins user configuration page), then `chmod 600 ~/.netrc`:

```
machine jenkins.example.com login <user> password <api-token>
```

Grep the log for the failing task or the first error and fix from the real failure. Do not try to reproduce it blind.

## One-time setup, the user must run these

Both need interactive input, so ask the user to run them with the `!` prefix rather than running them yourself:

- `! bkt auth login https://<host> --web-token`: DC personal access token (needs Repository Read/Write, Project Read), stored in the OS keychain. `--kind cloud` for Bitbucket Cloud. `bkt auth login --username X --token "$PAT"` exists for CI but exposes the token in the process list.
- The `~/.netrc` Jenkins line above.

`bkt` also ships `bkt mcp`, an MCP server for agents, if a session wants tool-level access instead of shell calls.
