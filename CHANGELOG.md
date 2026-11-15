# Changelog

- 2026-11-15
  - The tap starts with a `findbig` formula for py-findbig v0.5.0. It installs the script as the command `findbig`, with its manual page, from the release's source archive and depends on Homebrew's Python 3.15. Found internally from backlog item 577.
  - Continuous integration (CI) lints the YAML and the workflows, scans the full history for secrets with gitleaks, and on macOS checks the tap with `brew style` and `brew audit --strict --online`, then installs, tests, and uninstalls `findbig`.
