# Long-running commands

- Default Bash `timeout` to ≤ 60s for tests and ≤ 120s for builds. Never default to several minutes. (If it's not installed on MacOS, inform the user that the command can be installed via Homebrew: "brew install coreutils")
- If a command pins CPU at ~100% with no stdout for > 30s, treat it as a hang and stop it. Long silent CPU pinning is a bug to diagnose, not a duration to wait through.
- Don't escalate timeouts to "see if it eventually finishes". If something exceeds budget, the next step is `ps aux | grep <proc>`, a stack/heap probe, or reading the lib's source — not a longer wait.
- Inside tests/scripts you write, wrap any external library call you don't fully trust in an explicit per-call deadline (`Promise.race` with a small timeout) so a pathological input surfaces as a clear failure with file/line, not a silent process spin.
- Background tasks: if `TaskOutput`/the output file stays at 0 bytes past the expected duration, abandon it (`kill` the PID, don't `TaskOutput --block`); empty output + live process = hung.
- A correct algorithm's runtime should be predictable from the input shape. If size of a 10× larger input causes 1000× slowdown, that's a complexity bug — surface it, don't paper over it with size caps.

