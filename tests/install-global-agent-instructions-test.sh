#!/usr/bin/env bash
set -euo pipefail

SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
TEST_HOME="$(mktemp -d)"
CONFLICT_HOME="$(mktemp -d)"
trap 'rm -rf "$TEST_HOME" "$CONFLICT_HOME"' EXIT

HOME="$TEST_HOME" "$SETUP_ROOT/install.sh"

[[ "$(readlink "$TEST_HOME/.claude/CLAUDE.md")" == "$SETUP_ROOT/CLAUDE.md" ]]
[[ "$(readlink "$TEST_HOME/.codex/AGENTS.md")" == "$SETUP_ROOT/CLAUDE.md" ]]

HOME="$TEST_HOME" "$SETUP_ROOT/install.sh"
HOME="$TEST_HOME" "$SETUP_ROOT/install.sh" --check

rm "$TEST_HOME/.codex/AGENTS.md"
printf 'keep me\n' > "$TEST_HOME/.codex/AGENTS.md"

if HOME="$TEST_HOME" "$SETUP_ROOT/install.sh" 2>/dev/null; then
    printf 'expected the installer to refuse an existing regular file\n' >&2
    exit 1
fi

[[ "$(cat "$TEST_HOME/.codex/AGENTS.md")" == "keep me" ]]

mkdir -p "$CONFLICT_HOME/.codex"
printf 'keep me too\n' > "$CONFLICT_HOME/.codex/AGENTS.md"

if HOME="$CONFLICT_HOME" "$SETUP_ROOT/install.sh" 2>/dev/null; then
    printf 'expected the installer to reject all changes when one target conflicts\n' >&2
    exit 1
fi

[[ ! -e "$CONFLICT_HOME/.claude/CLAUDE.md" ]]
[[ "$(cat "$CONFLICT_HOME/.codex/AGENTS.md")" == "keep me too" ]]
