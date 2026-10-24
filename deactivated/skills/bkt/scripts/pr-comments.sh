#!/usr/bin/env bash
# Export Bitbucket Data Center PR review comments (file, line, diff context, replies) to Markdown.
#
# Usage: pr-comments.sh <pr-id> [--commits] [--out FILE] [--repo HOST/PROJECT/SLUG] [--raw FILE] [--stdout]
#
# Transport: Bitbucket REST /activities, authenticated with the credential git already
# stores for the remote host (macOS keychain via `git credential fill`). Falls back to
# `bkt api` when no such credential exists. Data Center only; Cloud uses a different API.

set -euo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RENDER_JQ="$SKILL_DIR/scripts/render-comments.jq"

PR_ID=""
OUT=""
REPO_OVERRIDE=""
RAW_OUT=""
TO_STDOUT=0
MODE="report"


die() { printf 'error: %s\n' "$*" >&2; exit 1; }

while [ $# -gt 0 ]; do
    case "$1" in
        --out) OUT="${2:-}"; shift 2 ;;
        --repo) REPO_OVERRIDE="${2:-}"; shift 2 ;;
        --raw) RAW_OUT="${2:-}"; shift 2 ;;
        --stdout) TO_STDOUT=1; shift ;;
        --commits) MODE="commits"; shift ;;
        -h|--help) sed -n '2,9p' "$0"; exit 0 ;;
        -*) die "unknown flag: $1" ;;
        *) [ -z "$PR_ID" ] || die "unexpected argument: $1"; PR_ID="$1"; shift ;;
    esac
done

[ -n "$PR_ID" ] || die "missing <pr-id>. Usage: pr-comments.sh <pr-id> [--commits] [--out FILE]"
command -v jq >/dev/null || die "jq is required (brew install jq)"

# --- locate the repository -----------------------------------------------------------
if [ -n "$REPO_OVERRIDE" ]; then
    IFS='/' read -r HOST PROJECT SLUG <<<"$REPO_OVERRIDE"
    [ -n "${SLUG:-}" ] || die "--repo must be HOST/PROJECT/SLUG"
else
    REMOTE="$(git config --get remote.origin.url 2>/dev/null || true)"
    [ -n "$REMOTE" ] || die "not in a git repository with an origin remote; pass --repo HOST/PROJECT/SLUG"
    # https://host/scm/PROJ/slug.git | ssh://git@host:7999/proj/slug.git | git@host:proj/slug.git
    STRIPPED="${REMOTE%.git}"
    STRIPPED="${STRIPPED#*://}"
    STRIPPED="${STRIPPED#*@}"
    HOST="${STRIPPED%%[:/]*}"
    PATH_PART="${STRIPPED#*[:/]}"
    PATH_PART="${PATH_PART#[0-9]*/}"   # drop an ssh port segment
    PATH_PART="${PATH_PART#scm/}"      # drop the DC https /scm prefix
    PROJECT="${PATH_PART%%/*}"
    SLUG="${PATH_PART##*/}"
    [ -n "$PROJECT" ] && [ -n "$SLUG" ] || die "cannot parse project/slug from remote: $REMOTE"
fi

API="https://$HOST/rest/api/1.0/projects/$PROJECT/repos/$SLUG/pull-requests/$PR_ID"

# --- transport -----------------------------------------------------------------------
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT   # holds a short-lived netrc; never leave it behind
NETRC="$WORK/netrc"

TRANSPORT=""
if creds="$(printf 'protocol=https\nhost=%s\n\n' "$HOST" | GIT_TERMINAL_PROMPT=0 git credential fill 2>/dev/null)"; then
    if printf '%s\n' "$creds" | grep -q '^password='; then
        ( umask 077
          printf '%s\n' "$creds" | awk -F= -v h="$HOST" \
            '/^username=/{u=substr($0,10)} /^password=/{p=substr($0,10)} END{printf "machine %s login %s password %s\n", h, u, p}' \
            > "$NETRC" )
        TRANSPORT="curl"
    fi
fi
unset creds
if [ -z "$TRANSPORT" ]; then
    command -v bkt >/dev/null || die "no git credential for $HOST and no bkt CLI. Run: git ls-remote (to store a credential) or bkt auth login https://$HOST"
    bkt auth status >/dev/null 2>&1 || die "no git credential for $HOST and bkt is not authenticated. Run: bkt auth login https://$HOST"
    TRANSPORT="bkt"   # assumes the active bkt context points at $HOST
    printf 'note: using `bkt api` (no git credential stored for %s)\n' "$HOST" >&2
fi

fetch() {   # fetch <path-with-query> -> JSON on stdout
    case "$TRANSPORT" in
        curl) curl -fsS --netrc-file "$NETRC" "https://$HOST$1" ;;
        bkt)  bkt api "$1" ;;
    esac
}

API_PATH="/rest/api/1.0/projects/$PROJECT/repos/$SLUG/pull-requests/$PR_ID"
fetch "$API_PATH" > "$WORK/pr.json" \
    || die "cannot read $API (check the PR id, the project key, and your credentials)"
jq -e '.id' "$WORK/pr.json" >/dev/null 2>&1 \
    || die "unexpected response for $API (not a pull request payload)"

# The payload carries the canonical browser URL; the remote's project key may differ in case.
PR_URL="$(jq -r --arg fallback "https://$HOST/projects/$PROJECT/repos/$SLUG/pull-requests/$PR_ID" \
    '.links.self[0].href // $fallback' "$WORK/pr.json")"

START=0
PAGE_LIMIT="${BKT_PAGE_LIMIT:-100}"   # lowered in tests to exercise the pagination loop
: > "$WORK/pages.jsonl"
while : ; do
    fetch "$API_PATH/activities?limit=$PAGE_LIMIT&start=$START" > "$WORK/page.json"
    jq -c '{values}' "$WORK/page.json" >> "$WORK/pages.jsonl"
    if [ "$(jq -r '.isLastPage' "$WORK/page.json")" = "true" ]; then break; fi
    START="$(jq -r '.nextPageStart' "$WORK/page.json")"
    [ "$START" != "null" ] || break
done
jq -s '{values: (map(.values) | add)}' "$WORK/pages.jsonl" > "$WORK/activities.json"

[ -z "$RAW_OUT" ] || cp "$WORK/activities.json" "$RAW_OUT"

# --- which commit was each comment written against? -------------------------------------
# Not readable from commentAnchor: Bitbucket rewrites it onto the current effective diff at
# every rescope. The RESCOPED log is the only record of where the head actually was.
# Note the inverted naming: in RESCOPED, fromHash is the source-branch head and toHash the
# target; in commentAnchor, fromHash is the base side and toHash the source head.
# t:0 on the synthetic first entry so comments written before the first rescope resolve too.
HEADS="$(jq -c '
  [.values[] | select(.action == "RESCOPED")] | sort_by(.createdDate) as $r
  | if ($r | length) == 0 then []
    else [{t: 0, head: $r[0].previousFromHash, base: $r[0].previousToHash}]
         + [$r[] | {t: .createdDate, head: .fromHash, base: .toHash}]
    end' "$WORK/activities.json")"
if [ "$HEADS" = "[]" ]; then
    HEADS="$(jq -c '[{t: 0, head: .fromRef.latestCommit, base: .toRef.latestCommit}]' "$WORK/pr.json")"
fi

SUBJECTS='{}'
if git rev-parse --git-dir >/dev/null 2>&1; then
    SUBJECTS="$(printf '%s\n' "$HEADS" | jq -r '.[] | .head, .base' | sort -u | while read -r sha; do
        [ -n "$sha" ] && [ "$sha" != "null" ] || continue
        subject="$(git log -1 --format=%s "$sha" 2>/dev/null || true)"
        [ -n "$subject" ] || continue          # commit not in this clone (force-push, or another repo)
        jq -cn --arg k "$sha" --arg v "$subject" '{($k): $v}'
    done | jq -cs 'add // {}')"
fi

# --- render ---------------------------------------------------------------------------
if [ -n "$OUT" ]; then
    :
elif [ "$MODE" = "commits" ]; then
    TO_STDOUT=1                                # the commit table is small; default it to stdout
else
    OUT="$HOME/Downloads/pr-$PR_ID-review-comments.md"
fi

jq -r --argjson pr "$(cat "$WORK/pr.json")" --arg prurl "$PR_URL" \
      --argjson heads "$HEADS" --argjson subjects "$SUBJECTS" --arg mode "$MODE" \
      -f "$RENDER_JQ" "$WORK/activities.json" > "$WORK/out.md"

if [ "$TO_STDOUT" = "1" ]; then
    cat "$WORK/out.md"
else
    cp "$WORK/out.md" "$OUT"
    printf '%s\n' "$OUT"
fi

jq -r '
  [.values[] | select(.action == "COMMENTED")] as $c
  | "comments: \($c | length) total, "
    + "\([$c[] | select(.commentAnchor != null)] | length) anchored, "
    + "\([$c[] | select(.comment.severity == "BLOCKER")] | length) blocker, "
    + "\([$c[] | select(.commentAnchor.orphaned == true)] | length) orphaned"
' "$WORK/activities.json" >&2
