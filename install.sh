#!/usr/bin/env bash
set -euo pipefail

SETUP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
AGENT_SETUP_HOME="${HOME:?HOME must be set}"
GLOBAL_INSTRUCTIONS="$SETUP_ROOT/CLAUDE.md"
CLAUDE_TARGET="$AGENT_SETUP_HOME/.claude/CLAUDE.md"
CODEX_TARGET="$AGENT_SETUP_HOME/.codex/AGENTS.md"

usage() {
    printf 'Usage: %s [--check]\n' "$0"
}

check_link() {
    local agent="$1"
    local target="$2"

    if [[ ! -L "$target" ]]; then
        printf 'FAIL %s: %s is not a symbolic link\n' "$agent" "$target" >&2
        return 1
    fi

    if [[ "$(readlink "$target")" != "$GLOBAL_INSTRUCTIONS" ]]; then
        printf 'FAIL %s: %s does not point to %s\n' "$agent" "$target" "$GLOBAL_INSTRUCTIONS" >&2
        return 1
    fi

    printf 'PASS %s: %s -> %s\n' "$agent" "$target" "$GLOBAL_INSTRUCTIONS"
}

validate_install_target() {
    local agent="$1"
    local target="$2"

    if [[ -L "$target" ]]; then
        if [[ "$(readlink "$target")" == "$GLOBAL_INSTRUCTIONS" ]]; then
            return 0
        fi
        printf 'REFUSE %s: %s already points somewhere else\n' "$agent" "$target" >&2
        return 1
    fi

    if [[ -e "$target" ]]; then
        printf 'REFUSE %s: %s already exists and is not a symbolic link\n' "$agent" "$target" >&2
        return 1
    fi
}

install_link() {
    local agent="$1"
    local target="$2"

    mkdir -p "$(dirname "$target")"
    if [[ ! -L "$target" ]]; then
        ln -s "$GLOBAL_INSTRUCTIONS" "$target"
    fi
    printf 'PASS %s: %s -> %s\n' "$agent" "$target" "$GLOBAL_INSTRUCTIONS"
}

case "${1:-}" in
    "")
        install_status=0
        validate_install_target "Claude Code" "$CLAUDE_TARGET" || install_status=1
        validate_install_target "Codex" "$CODEX_TARGET" || install_status=1
        if (( install_status != 0 )); then
            printf 'No links were changed. Move the conflicting files yourself, then retry.\n' >&2
            exit 1
        fi
        install_link "Claude Code" "$CLAUDE_TARGET"
        install_link "Codex" "$CODEX_TARGET"
        ;;
    --check)
        check_status=0
        check_link "Claude Code" "$CLAUDE_TARGET" || check_status=1
        check_link "Codex" "$CODEX_TARGET" || check_status=1
        exit "$check_status"
        ;;
    *)
        usage >&2
        exit 2
        ;;
esac
