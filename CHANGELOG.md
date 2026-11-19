# Changelog

- 2026-11-18
  - A Snyk job in continuous integration (CI) tests the Python tools pinned in `ci/requirements.txt`, which Snyk's repository import skips, and fails on any high or critical issue, a scan error, or a missing `SNYK_TOKEN` secret. The Snyk CLI 1.1308.4 is downloaded from its GitHub release and verified by its checksum; found internally from backlog item 572.
- 2026-11-15
  - The tap starts with a `findbig` formula for py-findbig v0.5.0. It installs the script as the command `findbig`, with its manual page, from the release's source archive and depends on Homebrew's Python 3.15. Found internally from backlog item 577.
  - Continuous integration (CI) lints the YAML and the workflows, scans the full history for secrets with gitleaks, and on macOS checks the tap with `brew style` and `brew audit --strict --online`, then installs, tests, and uninstalls `findbig`.
