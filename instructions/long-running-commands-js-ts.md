# Long-running commands

- Use the agent runner's native timeout, yield and background-session controls. The policy must work in both Codex and Claude Code; do not make shell `timeout` a prerequisite.
- Budget focused tests at 60 seconds and builds at 120 seconds unless the repository documents a measured exception. Never increase a budget merely to see whether a command eventually finishes.
- Start commands with a bounded foreground wait. If the runner yields a live task or session, retain its identifier, poll in windows of at most 30 seconds, and always terminate or reap it before abandoning the command.
- In Codex, use the command yield/session identifier and poll or terminate that session. In Claude Code, use the Bash timeout or background task identifier, inspect it with `TaskOutput`, and stop it with the available task or shell termination control.
- Shell-level deadlines such as GNU `timeout` or macOS Homebrew `gtimeout` are portable fallbacks for scripts and CI, not the default agent control mechanism.
- Treat a process as hung when it saturates a logical core for more than 30 seconds without an observable progress signal such as new output, advancing test counts or changing expected artifacts. Diagnose it with process inspection, a stack or heap probe, or the library source instead of extending the deadline.
- Silence alone is not proof of a hang. Low-CPU waiting and known quiet compiler phases may be legitimate, but they remain subject to the command budget.
- Inside tests or scripts, put explicit deadlines around untrusted external calls only at the risky boundary. Prefer cancellable APIs such as `AbortSignal`; a bare `Promise.race` reports a timeout but does not stop the underlying work.
- A correct algorithm's runtime should be predictable from the input shape. If a 10x larger input causes a 1000x slowdown, surface the complexity defect instead of hiding it with a larger timeout or smaller fixture.
