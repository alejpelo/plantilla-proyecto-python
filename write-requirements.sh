#!/bin/bash

FAILED=0

# Check if dvc option has been activated
CHECK_LIBRARY=$(uv pip show dvc)

if [[ -z "$CHECK_LIBRARY" ]]; then
  OPTION_DVC_ACTIVATED=false
else
  OPTION_DVC_ACTIVATED=true
fi

# Check if notebooks option has been activated
CHECK_LIBRARY=$(uv pip show marimo)

if [[ -z "$CHECK_LIBRARY" ]]; then
  OPTION_NOTEBOOKS_ACTIVATED=false
else
  OPTION_NOTEBOOKS_ACTIVATED=true
fi

# requirements
if [[ "$OPTION_DVC_ACTIVATED" == true && "$OPTION_NOTEBOOKS_ACTIVATED" == true ]]; then
    NEW_REQUIREMENTS=$(uv export --no-dev --no-hashes --frozen --no-header --no-annotate --extra dvc --extra notebooks)
elif [[ "$OPTION_DVC_ACTIVATED" == true && "$OPTION_NOTEBOOKS_ACTIVATED" == false ]]; then
    NEW_REQUIREMENTS=$(uv export --no-dev --no-hashes --frozen --no-header --no-annotate --extra dvc)
elif [[ "$OPTION_DVC_ACTIVATED" == false && "$OPTION_NOTEBOOKS_ACTIVATED" == true ]]; then
    NEW_REQUIREMENTS=$(uv export --no-dev --no-hashes --frozen --no-header --no-annotate --extra notebooks)
else
    NEW_REQUIREMENTS=$(uv export --no-dev --no-hashes --frozen --no-header --no-annotate)
fi

if [[ ! -f requirements.txt ]]; then
    echo "\033[0;31mFailed: requirements.txt didn't exist!\033[0m"
    echo "$NEW_REQUIREMENTS" > requirements.txt
    FAILED=1
fi

REQUIREMENTS=$(cat requirements.txt)

if [[ "$NEW_REQUIREMENTS" != "$REQUIREMENTS" ]]; then
    echo "\033[0;31mFailed: requirements.txt wasn't updated!\033[0m"
    echo "$NEW_REQUIREMENTS" > requirements.txt
    FAILED=1
fi

# dev requirements
if [[ "$OPTION_DVC_ACTIVATED" == true && "$OPTION_NOTEBOOKS_ACTIVATED" == true ]]; then
    NEW_REQUIREMENTS_DEV=$(uv export --no-hashes --frozen --no-header --no-annotate --extra dvc --extra notebooks)
elif [[ "$OPTION_DVC_ACTIVATED" == true && "$OPTION_NOTEBOOKS_ACTIVATED" == false ]]; then
    NEW_REQUIREMENTS_DEV=$(uv export --no-hashes --frozen --no-header --no-annotate --extra dvc)
elif [[ "$OPTION_DVC_ACTIVATED" == false && "$OPTION_NOTEBOOKS_ACTIVATED" == true ]]; then
    NEW_REQUIREMENTS_DEV=$(uv export --no-hashes --frozen --no-header --no-annotate --extra notebooks)
else
    NEW_REQUIREMENTS_DEV=$(uv export --no-hashes --frozen --no-header --no-annotate)
fi

if [[ ! -f requirements-dev.txt ]]; then
    echo "\033[0;31mFailed: requirements-dev.txt didn't exist!\033[0m"
    echo "$NEW_REQUIREMENTS_DEV" > requirements-dev.txt
    FAILED=1
fi

REQUIREMENTS_DEV=$(cat requirements-dev.txt)

if [[ "$NEW_REQUIREMENTS_DEV" != "$REQUIREMENTS_DEV" ]]; then
    echo "\033[0;31mFailed: requirements-dev.txt wasn't updated!\033[0m"
    echo "$NEW_REQUIREMENTS_DEV" > requirements-dev.txt
    FAILED=1
fi

# tests requirements
NEW_REQUIREMENTS_TESTS=$(uv export --no-dev --extra tests --no-hashes --frozen --no-header --no-annotate)

if [[ ! -f requirements-tests.txt ]]; then
    echo "\033[0;31mFailed: requirements-tests.txt didn't exist!\033[0m"
    echo "$NEW_REQUIREMENTS_TESTS" > requirements-tests.txt
    FAILED=1
fi

REQUIREMENTS_TESTS=$(cat requirements-tests.txt)

if [[ "$NEW_REQUIREMENTS_TESTS" != "$REQUIREMENTS_TESTS" ]]; then
    echo "\033[0;31mFailed: requirements-tests.txt wasn't updated!\033[0m"
    echo "$NEW_REQUIREMENTS_TESTS" > requirements-tests.txt
    FAILED=1
fi

# docs requirements
NEW_REQUIREMENTS_DOCS=$(uv export --no-dev --extra docs --no-hashes --frozen --no-header --no-annotate)

if [[ ! -f requirements-docs.txt ]]; then
    echo "\033[0;31mFailed: requirements-docs.txt didn't exist!\033[0m"
    echo "$NEW_REQUIREMENTS_DOCS" > requirements-docs.txt
    FAILED=1
fi

REQUIREMENTS_DOCS=$(cat requirements-docs.txt)

if [[ "$NEW_REQUIREMENTS_DOCS" != "$REQUIREMENTS_DOCS" ]]; then
    echo "\033[0;31mFailed: requirements-docs.txt wasn't updated!\033[0m"
    echo "$NEW_REQUIREMENTS_DOCS" > requirements-docs.txt
    FAILED=1
fi

if [[ "$FAILED" -eq 1 ]]; then
    exit 1
else
    echo "All requirements' files are up to date"
    exit 0
fi
