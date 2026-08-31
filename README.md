# coding-setup

This repository is the version-controlled source of mbackschat's global coding-agent instructions and reusable skills. [`CLAUDE.md`](CLAUDE.md) is deliberately tool-neutral except where a rule names one tool, and is the canonical global instruction file for both Claude Code and Codex.

## Install the global instructions

Clone the repository on each machine, then run the guarded installer from the checkout:

```sh
git clone https://github.com/mbackschat/coding-setup.git
cd coding-setup
./install.sh
./install.sh --check
```

The installer creates these links:

| Agent | Global instruction path | Link target |
|---|---|---|
| Claude Code | `~/.claude/CLAUDE.md` | this checkout's `CLAUDE.md` |
| Codex | `~/.codex/AGENTS.md` | this checkout's `CLAUDE.md` |

The installer is idempotent and refuses to replace an existing file or a link owned by another setup. Resolve such a conflict explicitly instead of deleting or overwriting agent configuration automatically.

Pulling this repository updates the shared instructions immediately because both agents read the tracked file through their respective global links. Start a new agent session after changing the instructions; an already-running session retains the context with which it started.

Project-level `CLAUDE.md` and `AGENTS.md` files remain responsible for repository-specific contracts. They complement these personal defaults and ensure that a project does not depend on one maintainer's global setup.

## Verify an active session

`./install.sh --check` verifies filesystem installation, not the context of an already-running agent. For a smoke check, start a fresh session and ask the agent for the magic marker from its active global instructions without allowing it to read the instruction file. That demonstrates injection for the session, but it is not a security boundary.
