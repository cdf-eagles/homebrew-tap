[![CI](https://github.com/cdf-eagles/homebrew-tap/actions/workflows/ci.yaml/badge.svg)](https://github.com/cdf-eagles/homebrew-tap/actions/workflows/ci.yaml)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=cdf-eagles_homebrew-tap&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=cdf-eagles_homebrew-tap)

# Homebrew tap

A [Homebrew](https://brew.sh) tap for this account's command-line tools.

| Formula | Installs | Source |
|---|---|---|
| `findbig` | the command `findbig`, which lists the largest files and directories under a directory, and its manual page (`man findbig`) | [py-findbig](https://github.com/cdf-eagles/py-findbig) |

## Installation

```sh
brew install cdf-eagles/tap/findbig
```

Homebrew taps the repository on first use; the tap's name, `cdf-eagles/tap`, is this repository's name without its `homebrew-` prefix. Formulae from a tap outside Homebrew's own must be trusted before Homebrew loads them; if it refuses to, trust the formula (or the whole tap with `brew trust --tap cdf-eagles/tap`) and install again:

```sh
brew trust --formula cdf-eagles/tap/findbig
brew install cdf-eagles/tap/findbig
```

`brew upgrade findbig` installs new releases. The formula installs py-findbig's script from the release's source archive and depends on Homebrew's Python, so it needs no build step and has no bottles.

## Updates

Each formula follows its project's releases: a new py-findbig release changes the formula's `url` and `sha256` through a pull request, which merges only after CI passes. The tap itself is not versioned or released.

## Continuous integration

`.github/workflows/ci.yaml` runs on every pull request to `main`, every push of `main`, weekly, and by hand. `main` requires the `Lint`, `Secret scan`, and `Formula` checks.

| Job | Runner | Does |
|---|---|---|
| `Lint` | Ubuntu 24.04 | `yamllint --strict`, then the pre-commit hooks: workflow and Dependabot schema checks, actionlint with shellcheck, whitespace and private-key checks, and ripsecrets |
| `Secret scan` | Ubuntu 24.04 | gitleaks over the full history of an unshallow clone |
| `Snyk` | Ubuntu 24.04 | installs the Python tools pinned in `ci/requirements.txt` and tests them with the Snyk command-line interface (CLI); fails on any high or critical dependency issue, a scan error, or a missing `SNYK_TOKEN` secret, which is set both as an Actions secret and as a Dependabot secret because Dependabot's pull requests cannot read Actions secrets |
| `Formula` | macOS 15 | updates Homebrew, taps the checkout, runs `brew style` (Homebrew's RuboCop rules for formulae) and `brew audit --strict --online` over the tap, installs and tests `findbig`, checks that `findbig --version` names the installed version and that `man -w findbig` finds the manual page, then uninstalls it |
| `Tool drift` | Ubuntu 24.04 | weekly only: opens an issue when a pinned tool that Dependabot cannot update falls behind |

SonarCloud analyses every pull request and `main` on its own (automatic analysis); its quality gate shows on the pull request but is not a required check. Snyk's GitHub integration checks pull requests too.

## Contributing

* Work reaches `main` only through squash-merged pull requests from branches named `<type>/<short-description>`, with type one of `feat`, `fix`, `chore`, `docs`, or `ci`.
* Set up the checks:
  * `python3 -m venv .venv`
  * `.venv/bin/pip install -r ci/requirements.txt`
  * `PATH="$PWD/.venv/bin:$PATH" pre-commit install`
  * `PATH="$PWD/.venv/bin:$PATH" pre-commit run --all-files` and `PATH="$PWD/.venv/bin:$PATH" yamllint --strict .`
  * The `pre-push` hook runs gitleaks over the commits being pushed, so install it (`brew install gitleaks`).
* Test a formula from a working copy by linking the clone into Homebrew as the tap, as CI does, instead of `brew tap` (untap any earlier copy first with `brew untap cdf-eagles/tap`):
  * `mkdir -p "$(brew --repository)/Library/Taps/cdf-eagles"`
  * `ln -s "$PWD" "$(brew --repository)/Library/Taps/cdf-eagles/homebrew-tap"`
  * `brew trust --tap cdf-eagles/tap`
  * `brew audit --strict --online --tap=cdf-eagles/tap`, `brew install --formula cdf-eagles/tap/findbig`, and `brew test cdf-eagles/tap/findbig`

### Where versions live

* Python tools (pre-commit, yamllint, check-jsonschema, shellcheck-py): `ci/requirements.txt`, exact `==` pins.
* Pre-commit hooks: the `rev:` of each hook in `.pre-commit-config.yaml`.
* gitleaks in CI: `GITLEAKS_VERSION` and `GITLEAKS_SHA256` in `.github/workflows/ci.yaml`.
* The Snyk CLI in CI: `SNYK_VERSION` and `SNYK_SHA256` in `.github/workflows/ci.yaml`.
* The Python a formula depends on: its `depends_on "python@3.y"` line, raised by hand when Homebrew's `python3` moves to a new minor version.

Dependabot opens weekly pull requests for the Python tools, the hooks, and the actions; the weekly Tool drift job covers gitleaks and the Snyk CLI.

## License

BSD 3-Clause; see `LICENSE`. Each formula's software carries its own license.
