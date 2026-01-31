#  Justfile for managing development tasks
#
#  Requires:
#    - just (https://github.com/casey/just)
#    - uv (https://docs.astral.sh/uv/)
#
# Author: [Alejandro Perez Londoño](mailto:perezl.alejandro@gmail.com)



# List all available just recipes
default:
  @just --list --unsorted


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Displays system information
[group('Info')]
system-info:
  @echo "Instruction set architecture: {{BOLD + CYAN + arch() + NORMAL}}".
  @echo "Operating System Family: {{BOLD + CYAN + os_family() + NORMAL}}".
  @echo "Operating System: {{BOLD + CYAN + os() + NORMAL}}".
  @echo "CPU Cores: {{BOLD + CYAN + num_cpus() + NORMAL}}".


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Sets up the development environment. To include additional extras, pass them as options (e.g. "--extra dvc", "--extra nb" or "--extra dvc" "--extra nb")
[group('Initial Setup')]
set-dev-env *EXTRAS:
  @uv sync -q --all-groups {{EXTRAS}}


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Installs pre-commit hooks
[group('Initial Setup')]
install-prek-hooks:
  @uv run prek install --hook-type commit-msg --hook-type pre-commit --hook-type pre-push


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Updates the development environment
[group('Environment Management')]
update-env:
  #!/usr/bin/env bash

  set -euo pipefail

  printf "{{BOLD + BLUE}}Updating the virtual environment => uv...{{NORMAL}}\n"

  FAILED=0


  # Check if notebooks option has been activated
  LIBRARY="marimo"
  CHECK_LIBRARY=$(uv pip list -q | grep -c $LIBRARY || true)

  if [ "$CHECK_LIBRARY" -gt 0 ]; then
  OPTION_NB_ACTIVATED=true
  else
  OPTION_NB_ACTIVATED=false
  fi
  printf "{{CYAN}}nb{{NORMAL}} activated: {{CYAN}}$OPTION_NB_ACTIVATED{{NORMAL}}\n"


  # Check if dvc option has been activated
  LIBRARY="dvc"
  CHECK_LIBRARY=$(uv pip list -q | grep -c $LIBRARY || true)

  if [ "$CHECK_LIBRARY" -gt 0 ]; then
  OPTION_DVC_ACTIVATED=true
  else
  OPTION_DVC_ACTIVATED=false
  fi
  printf "{{CYAN}}dvc{{NORMAL}} activated: {{CYAN}}$OPTION_NB_ACTIVATED{{NORMAL}}\n"


  # Update the environment
  if [[ "$OPTION_NB_ACTIVATED" == true && "$OPTION_DVC_ACTIVATED" == true ]]; then
  uv sync -q --upgrade --all-groups --all-extras
  elif [[ "$OPTION_NB_ACTIVATED" == true && "$OPTION_DVC_ACTIVATED" == false ]]; then
  uv sync -q --upgrade --all-groups --extra nb
  elif [[ "$OPTION_NB_ACTIVATED" == false && "$OPTION_DVC_ACTIVATED" == true ]]; then
  uv sync -q --upgrade --all-groups --extra dvc
  else
  uv sync -q --upgrade --all-groups
  fi


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Checks and verifies the development environment
[group('Environment Management')]
check-env:
  @printf "{{BOLD + BLUE}}Checking and verifying the virtual environment => uv...{{NORMAL}}\n"
  @uv lock -q --check


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Type-checks the code
[group('Code Management')]
type-check-code:
  @printf "{{BOLD + BLUE}}Type-checking code => ty...{{NORMAL}}\n"
  @uv run ty check


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Lints the code
[group('Code Management')]
lint-code:
  @printf "{{BOLD + BLUE}}Linting code => ruff...{{NORMAL}}\n"
  @uv run ruff check .


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Formats the code
[group('Code Management')]
format-code:
  @printf "{{BOLD + BLUE}}Formatting code => ruff...{{NORMAL}}\n"
  @uv run ruff format


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Runs tests with coverage
[group('Code Management')]
test-code:
  @printf "{{BOLD + BLUE}}Testing code => pytest...{{NORMAL}}\n"
  @uv run pytest --cov
  @uv run coverage report


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Updates requirements (.txt) files
[group('Code Management')]
update-reqs:
  #!/usr/bin/env bash

  set -euo pipefail

  printf "{{BOLD + BLUE}}Updating requirements files...{{NORMAL}}\n"

  FAILED=0


  # Check if notebooks option has been activated
  LIBRARY="marimo"
  CHECK_LIBRARY=$(uv pip list -q | grep -c $LIBRARY || true)

  if [ "$CHECK_LIBRARY" -gt 0 ]; then
  OPTION_NB_ACTIVATED=true
  else
  OPTION_NB_ACTIVATED=false
  fi
  printf "{{CYAN}}nb{{NORMAL}} activated: {{CYAN}}$OPTION_NB_ACTIVATED{{NORMAL}}\n"


  # Check if dvc option has been activated
  LIBRARY="dvc"
  CHECK_LIBRARY=$(uv pip list -q | grep -c $LIBRARY || true)

  if [ "$CHECK_LIBRARY" -gt 0 ]; then
  OPTION_DVC_ACTIVATED=true
  else
  OPTION_DVC_ACTIVATED=false
  fi
  printf "{{CYAN}}dvc{{NORMAL}} activated: {{CYAN}}$OPTION_NB_ACTIVATED{{NORMAL}}\n"


  # requirements
  if [[ "$OPTION_NB_ACTIVATED" == true && "$OPTION_DVC_ACTIVATED" == true ]]; then
  NEW_REQUIREMENTS=$(uv export -q --no-default-groups --no-hashes --frozen --no-header --no-annotate --extra nb --extra dvc)
  elif [[ "$OPTION_NB_ACTIVATED" == true && "$OPTION_DVC_ACTIVATED" == false ]]; then
  NEW_REQUIREMENTS=$(uv export -q --no-default-groups --no-hashes --frozen --no-header --no-annotate --extra nb)
  elif [[ "$OPTION_NB_ACTIVATED" == false && "$OPTION_DVC_ACTIVATED" == true ]]; then
  NEW_REQUIREMENTS=$(uv export -q --no-default-groups --no-hashes --frozen --no-header --no-annotate --extra dvc)
  else
  NEW_REQUIREMENTS=$(uv export -q --no-default-groups --no-hashes --frozen --no-header --no-annotate)
  fi

  if [[ ! -f requirements.txt ]]; then
  printf "{{RED}}Failed: {{BOLD}}requirements.txt {{NORMAL + RED}}didn't exist. {{NORMAL}}It has been created.\n"
  echo "$NEW_REQUIREMENTS" > requirements.txt
  FAILED=1
  fi

  REQUIREMENTS=$(cat requirements.txt)

  if [[ "$NEW_REQUIREMENTS" != "$REQUIREMENTS" ]]; then
  printf "{{RED}}Failed: {{BOLD}}requirements.txt {{NORMAL + RED}}wasn't updated. {{NORMAL}}It has been recreated.\n"
  echo "$NEW_REQUIREMENTS" > requirements.txt
  FAILED=1
  fi


  # dev requirements
  if [[ "$OPTION_NB_ACTIVATED" == true && "$OPTION_DVC_ACTIVATED" == true ]]; then
  NEW_REQUIREMENTS_DEV=$(uv export -q --only-dev --no-hashes --frozen --no-header --no-annotate --extra nb --extra dvc)
  elif [[ "$OPTION_NB_ACTIVATED" == true && "$OPTION_DVC_ACTIVATED" == false ]]; then
  NEW_REQUIREMENTS_DEV=$(uv export -q --only-dev --no-hashes --frozen --no-header --no-annotate --extra nb)
  elif [[ "$OPTION_NB_ACTIVATED" == false && "$OPTION_DVC_ACTIVATED" == true ]]; then
  NEW_REQUIREMENTS_DEV=$(uv export -q --only-dev --no-hashes --frozen --no-header --no-annotate --extra dvc)
  else
  NEW_REQUIREMENTS_DEV=$(uv export -q --only-dev --no-hashes --frozen --no-header --no-annotate)
  fi

  if [[ ! -f requirements-dev.txt ]]; then
  printf "{{RED}}Failed: {{BOLD}}requirements-dev.txt {{NORMAL + RED}}didn't exist. {{NORMAL}}It has been created.\n"
  echo "$NEW_REQUIREMENTS_DEV" > requirements-dev.txt
  FAILED=1
  fi

  REQUIREMENTS_DEV=$(cat requirements-dev.txt)

  if [[ "$NEW_REQUIREMENTS_DEV" != "$REQUIREMENTS_DEV" ]]; then
  printf "{{RED}}Failed: {{BOLD}}requirements-dev.txt {{NORMAL + RED}}wasn't updated. {{NORMAL}}It has been recreated.\n"
  echo "$NEW_REQUIREMENTS_DEV" > requirements-dev.txt
  FAILED=1
  fi


  # tests requirements
  NEW_REQUIREMENTS_TESTS=$(uv export -q --no-dev --only-group tests --no-hashes --frozen --no-header --no-annotate)

  if [[ ! -f requirements-tests.txt ]]; then
  printf "{{RED}}Failed: {{BOLD}}requirements-tests.txt {{NORMAL + RED}}didn't exist. {{NORMAL}}It has been created.\n"
  echo "$NEW_REQUIREMENTS_TESTS" > requirements-tests.txt
  FAILED=1
  fi

  REQUIREMENTS_TESTS=$(cat requirements-tests.txt)

  if [[ "$NEW_REQUIREMENTS_TESTS" != "$REQUIREMENTS_TESTS" ]]; then
  printf "{{RED}}Failed: {{BOLD}}requirements-tests.txt {{NORMAL + RED}}wasn't updated. {{NORMAL}}It has been recreated.\n"
  echo "$NEW_REQUIREMENTS_TESTS" > requirements-tests.txt
  FAILED=1
  fi


  # docs requirements
  NEW_REQUIREMENTS_DOCS=$(uv export -q --no-dev --only-group docs --no-hashes --frozen --no-header --no-annotate)

  if [[ ! -f requirements-docs.txt ]]; then
  printf "{{RED}}Failed: {{BOLD}}requirements-docs.txt {{NORMAL + RED}}didn't exist. {{NORMAL}}It has been created.\n"
  echo "$NEW_REQUIREMENTS_DOCS" > requirements-docs.txt
  FAILED=1
  fi

  REQUIREMENTS_DOCS=$(cat requirements-docs.txt)

  if [[ "$NEW_REQUIREMENTS_DOCS" != "$REQUIREMENTS_DOCS" ]]; then
  printf "{{RED}}Failed: {{BOLD}}requirements-docs.txt {{NORMAL + RED}}wasn't updated. {{NORMAL}}It has been recreated.\n"
  echo "$NEW_REQUIREMENTS_DOCS" > requirements-docs.txt
  FAILED=1
  fi


  if [[ "$FAILED" -eq 1 ]]; then
  exit 1
  else
  printf "{{GREEN}}All requirements' files are up to date{{NORMAL}}\n"
  exit 0
  fi


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Checks for code vulnerabilities
[group('Code Management')]
check-vulnerabilities:
  @printf "{{BOLD + BLUE}}Checking vulnerabilities => pip-audit...{{NORMAL}}\n"
  @uv run pip-audit


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

alias pc := run-pre-commit-checks
# Run pre-commit hooks
[group('Pre-Commit/Pre-Push Checks')]
run-pre-commit-checks:
  @printf "{{BOLD + BLUE}}Running pre-COMMIT checks => just...{{NORMAL}}\n"
  @just check-env type-check-code lint-code format-code update-reqs


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

alias pp := run-pre-push-checks
# Run pre-push hooks
[group('Pre-Commit/Pre-Push Checks')]
run-pre-push-checks:
  @printf "{{BOLD + BLUE}}Running pre-PUSH checks => just...{{NORMAL}}\n"
  @just run-pre-commit-checks test-code check-vulnerabilities


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

alias u := update-code
# Updates code from remote repository
[group('Commit and Code Version Management')]
update-code:
  @printf "{{BOLD + BLUE}}Updating code => git...{{NORMAL}}\n"
  @git fetch --all --tags
  @git pull


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

alias b := create-branch
# Creates a new branch
[group('Commit and Code Version Management')]
create-branch NEW_BRANCH_NAME ORIGIN_BRANCH="dev":
  @printf "{{BOLD + BLUE}}Creating new branch => git...{{NORMAL}}\n"
  @git checkout {{ORIGIN_BRANCH}}  # (e.g. main, dev)
  @git pull origin {{ORIGIN_BRANCH}}  # (e.g. fix/issue-123, feature/new-feature)
  @git checkout -b {{NEW_BRANCH_NAME}}
  @git push --set-upstream origin {{NEW_BRANCH_NAME}}


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

alias c := commit-code
# Makes commits with commitizen
[group('Commit and Code Version Management')]
commit-code:
  @printf "{{BOLD + BLUE}}Commiting code => commitizen...{{NORMAL}}\n"
  @just run-pre-commit-checks
  @uv run cz commit


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

alias p := push-code
# Pushes commits to the remote repository
[group('Commit and Code Version Management')]
push-code:
  @printf "{{BOLD + BLUE}}Pushing code to remote => git...{{NORMAL}}\n"
  @git push
  @git push origin --tags


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

alias bump := bump-code-version
# Bumps the project version
[group('Commit and Code Version Management')]
bump-code-version:
  @printf "{{BOLD + BLUE}}Bumping project version => commitizen & git...{{NORMAL}}\n"
  @just update-code
  @just run-pre-push-checks
  @uv run cz bump
  @just push-code


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Serves the documentation at http://localhost:8000
[group('Docs')]
serve-docs:
  @uv run mkdocs serve


# -------------------------------------------------------------------------------------------------------------------------------------------------------------

# Builds and publish the documentation site on GitHub Pages
[group('Docs')]
publish-docs:
  @uv run mkdocs gh-deploy
