# Renders Bitbucket Data Center PR activities into a review-comment report.
#
# Inputs:
#   $pr        pull-request JSON
#   $prurl     browser URL of the PR
#   $heads     [{t, head, base}] source-branch head timeline replayed from RESCOPED activities
#   $subjects  {sha: "commit subject"} for hashes resolvable in the local clone
#   $mode      "report" (full Markdown) or "commits" (comment-to-commit table only)
# Stdin: { "values": [ ...activities... ] }

def ts: (. / 1000 | floor | todate);
def rep($n): if $n <= 0 then "" else (" " * $n) end;
def pad($w): tostring | . as $s | (rep($w - ($s | length))) + $s;
def quote: (. // "") | split("\n") | map("> " + .) | join("\n");
def indent($n): split("\n") | map(rep($n) + .) | join("\n");
def short: if . == null then "-" else .[0:8] end;

# A comment's anchor is rewritten onto the current effective diff at every rescope, so the
# commit it was written against only survives in the RESCOPED log: last entry at or before it.
def headAt($t): ([$heads[] | select(.t <= $t)] | last) // {head: null, base: null};
def subject($sha): ($subjects[$sha // ""] // "");
def commitLabel($sha):
  "`" + ($sha | short) + "`" + (if subject($sha) == "" then "" else " " + subject($sha) end);

def replies($depth; $ctxHead):
  if ((.comments // []) | length) == 0 then ""
  else
    ( .comments
      | map(
          (headAt(.createdDate)) as $h
          | "\n" + rep($depth * 2) + "- **" + (.author.displayName) + "** ("
            + (.createdDate | ts) + ", comment " + (.id | tostring) + ")"
            + (if $h.head != $ctxHead then " _written against `" + ($h.head | short) + "`_" else "" end)
            + ":\n\n"
          + ((.text | quote) | indent(($depth + 1) * 2)) + "\n"
          + replies($depth + 1; $h.head)
        )
      | join("")
    )
  end;

def marker: if . == "ADDED" then "+" elif . == "REMOVED" then "-" else " " end;

# Bitbucket returns the hunks surrounding an anchored comment; the anchored line
# is the one carrying commentIds.
def hunkblock:
  ( .diff.hunks // [] )
  | map(
      "@@ -" + (.sourceLine | tostring) + "," + (.sourceSpan | tostring)
      + " +" + (.destinationLine | tostring) + "," + (.destinationSpan | tostring) + " @@\n"
      + ( [ .segments[]
            | .type as $t
            | .lines[]
            | ($t | marker)
              + ( (if $t == "REMOVED" then .source else .destination end) | pad(5) )
              + "  " + .line
              + ( if ((.commentIds // []) | length) > 0 then "        <-- COMMENT ANCHORED HERE" else "" end )
          ] | join("\n") )
    )
  | join("\n\n");

def anchored:
  [ .values[] | select(.action == "COMMENTED" and .commentAnchor != null) ]
  | sort_by(.commentAnchor.path, .commentAnchor.line);

def general:
  [ .values[] | select(.action == "COMMENTED" and .commentAnchor == null) ]
  | sort_by(.comment.createdDate);

def location:
  if .commentAnchor == null then "(general)"
  else .commentAnchor.path + ":" + (.commentAnchor.line | tostring) end;

# Every comment and reply flattened to one row, each carrying the head it was written against.
def flat:
  [ .values[] | select(.action == "COMMENTED") ]
  | map(
      location as $loc
      | ( [ .comment
            | recurse(.comments[]?)
            | {id, t: .createdDate, author: .author.displayName, loc: $loc}
          ] )
      | to_entries
      | map(.value + {kind: (if .key == 0 then "comment" else "reply" end)})
    )
  | add // []
  | map(. + {h: headAt(.t)})
  | sort_by(.t);

def commitSummary:
  flat
  | group_by(.h.head)
  | map({ head: .[0].h.head, base: .[0].h.base, n: length,
          first: (map(.t) | min | ts), last: (map(.t) | max | ts) })
  | sort_by(.first);

def commitsTable:
  "# PR " + ($pr.id | tostring) + " comments by commit\n"
  + "\n- PR: " + $prurl + "\n"
  + "- Head at comment time is replayed from the PR's RESCOPED activities. The `commentAnchor`"
    + " hashes are NOT this: Bitbucket re-anchors every comment onto the current effective diff.\n"
  + "\n## Summary\n\n"
  + "| Head at comment time | Base | Comments | First | Last |\n|---|---|---|---|---|\n"
  + ( commitSummary
      | map("| " + commitLabel(.head) + " | `" + (.base | short) + "` | " + (.n | tostring)
            + " | " + .first + " | " + .last + " |")
      | join("\n") )
  + "\n\n## Per comment\n\n"
  + "| Comment | Kind | Time (UTC) | Head at comment time | Base | Location |\n|---|---|---|---|---|---|\n"
  + ( flat
      | map("| `" + (.id | tostring) + "` | " + .kind + " | " + (.t | ts)
            + " | `" + (.h.head | short) + "` | `" + (.h.base | short) + "` | `" + .loc + "` |")
      | join("\n") )
  + "\n";

def report:
  "# PR " + ($pr.id | tostring) + " review comments: " + ($pr.title) + "\n"
  + "\n"
  + "- PR: " + $prurl + "\n"
  + "- Source: `" + ($pr.fromRef.displayId) + "` -> `" + ($pr.toRef.displayId) + "`\n"
  + "- PR author: " + ($pr.author.user.displayName) + " | State: " + ($pr.state) + "\n"
  + "- Created: " + ($pr.createdDate | ts) + " | Updated: " + ($pr.updatedDate | ts) + "\n"
  + "- Anchored review comments: " + ((anchored | length) | tostring)
    + " | General comments: " + ((general | length) | tostring) + "\n"
  + "- Source: Bitbucket REST `pull-requests/" + ($pr.id | tostring)
    + "/activities`. Ordered by file path, then line. Timestamps UTC.\n"
  + "\n## Commits these comments were written against\n\n"
  + "| Head at comment time | Base | Comments and replies | First | Last |\n|---|---|---|---|---|\n"
  + ( commitSummary
      | map("| " + commitLabel(.head) + " | `" + (.base | short) + "` | " + (.n | tostring)
            + " | " + .first + " | " + .last + " |")
      | join("\n") )
  + "\n\nReplayed from the PR's RESCOPED activities. The `commentAnchor` hashes point at the current"
    + " effective diff instead, because Bitbucket re-anchors comments on every rescope.\n"
  + "\n---\n\n## Anchored review comments\n"
  + ( if (anchored | length) == 0 then "\n_None._\n" else "" end )
  + ( anchored
      | to_entries
      | map(
          .key as $i | .value as $a
          | (headAt($a.comment.createdDate)) as $h
          | "\n### " + (($i + 1) | tostring) + ". `" + $a.commentAnchor.path
            + "` line " + ($a.commentAnchor.line | tostring) + "\n"
          + "\n"
          + "- Comment `" + ($a.comment.id | tostring) + "` by **" + $a.comment.author.displayName
            + "** on " + ($a.comment.createdDate | ts) + "\n"
          + "- Written against: " + commitLabel($h.head) + " (base `" + ($h.base | short) + "`)\n"
          + "- State: " + ($a.comment.state) + " | Severity: " + ($a.comment.severity)
            + " | Anchor: " + ($a.commentAnchor.lineType) + " line in "
            + (if $a.commentAnchor.fileType == "TO" then "new file" else "old file" end)
            + (if ($a.commentAnchor.orphaned // false) then " | ORPHANED (code moved since)" else "" end) + "\n"
          + "- Link: " + $prurl + "/overview?commentId=" + ($a.comment.id | tostring) + "\n"
          + "\n**Comment**\n\n" + ($a.comment.text | quote) + "\n"
          + ( if ($a.diff // null) != null
              then "\n**Code context**\n\n```diff\n" + ($a | hunkblock) + "\n```\n"
              else "\n_No diff context returned for this comment._\n" end )
          + ( if (($a.comment.comments // []) | length) > 0
              then "\n**Replies**\n" + ($a.comment | replies(0; $h.head)) + "\n"
              else "\n_No replies._\n" end )
          + "\n---\n"
        )
      | join("") )
  + "\n## General (non-anchored) comments\n"
  + ( if (general | length) == 0 then "\n_None._\n" else "" end )
  + ( general
      | map(
          (headAt(.comment.createdDate)) as $h
          | "\n### Comment `" + (.comment.id | tostring) + "` by " + .comment.author.displayName
            + " on " + (.comment.createdDate | ts) + "\n\n"
          + "- Written against: " + commitLabel($h.head) + " (base `" + ($h.base | short) + "`)\n\n"
          + (.comment.text | quote) + "\n"
          + ( if ((.comment.comments // []) | length) > 0
              then (.comment | replies(0; $h.head)) + "\n" else "" end )
        )
      | join("") );

if $mode == "commits" then commitsTable else report end
