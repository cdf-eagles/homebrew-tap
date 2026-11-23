# Changelog

- 2026-11-23
  - Continuous integration (CI) retries each pinned tool download (`--retry 8 --retry-delay 30 --retry-max-time 300 --retry-all-errors`) for up to about five minutes, so a passing error from GitHub's release download service, such as the 504 replies of 2026-11-08, no longer fails the job before its checks run; the SHA-256 check after each download is unchanged. Found internally from backlog item 516.
- 2026-11-22
  - Continuous integration (CI) installs Python 3.13.18 with `actions/setup-python` (`PYTHON_VERSION` in the workflow's `env:` block) in every job that runs Python, instead of using the runner image's own `python3`, whose version changed with the image. The weekly Tool drift job checks the pin against its line's latest patch release. Found internally from backlog item 536.
- 2026-11-18
  - A Snyk job in continuous integration (CI) tests the Python tools pinned in `ci/requirements.txt`, which Snyk's repository import skips, and fails on any high or critical issue, a scan error, or a missing `SNYK_TOKEN` secret. The Snyk CLI 1.1308.4 is downloaded from its GitHub release and verified by its checksum; found internally from backlog item 572.
- 2026-11-15
  - The tap starts with a `findbig` formula for py-findbig v0.5.0. It installs the script as the command `findbig`, with its manual page, from the release's source archive and depends on Homebrew's Python 3.15. Found internally from backlog item 577.
  - Continuous integration (CI) lints the YAML and the workflows, scans the full history for secrets with gitleaks, and on macOS checks the tap with `brew style` and `brew audit --strict --online`, then installs, tests, and uninstalls `findbig`.
