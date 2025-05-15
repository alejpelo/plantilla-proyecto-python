#!/bin/bash

FAILED=false

# requirements
NEW_REQUIREMENTS=$(uv export --no-dev --no-hashes --frozen --no-header --no-annotate)

if [ ! -f requirements.txt ]; then
    echo "\033[0;31mFailed: requirements.txt didn't exist!\033[0m"
    uv export --no-dev --no-hashes --frozen --no-header --no-annotate --format requirements-txt > requirements.txt
    FAILED=True
fi

REQUIREMENTS=$(cat requirements.txt)

if [ "$NEW_REQUIREMENTS" != "$REQUIREMENTS" ]; then
    echo "\033[0;31mFailed: requirements.txt wasn't updated!\033[0m"
    uv export --no-dev --no-hashes --frozen --no-header --no-annotate --format requirements-txt > requirements.txt
    FAILED=True
fi

# dev requirements
NEW_REQUIREMENTS_DEV=$(uv export --no-hashes --frozen --no-header --no-annotate)

if [ ! -f requirements-dev.txt ]; then
    echo "\033[0;31mFailed: requirements-dev.txt didn't exist!\033[0m"
    uv export --no-hashes --frozen --no-header --no-annotate --format requirements-txt > requirements-dev.txt
    FAILED=True
fi

REQUIREMENTS_DEV=$(cat requirements-dev.txt)

if [ "$NEW_REQUIREMENTS_DEV" != "$REQUIREMENTS_DEV" ]; then
    echo "\033[0;31mFailed: requirements-dev.txt wasn't updated!\033[0m"
    uv export --no-hashes --frozen --no-header --no-annotate --format requirements-txt > requirements-dev.txt
    FAILED=true
fi

# tests requirements
NEW_REQUIREMENTS_TESTS=$(uv export --no-dev --extra tests --no-hashes --frozen --no-header --no-annotate)

if [ ! -f requirements-tests.txt ]; then
    echo "\033[0;31mFailed: requirements-tests.txt didn't exist!\033[0m"
    uv export --no-dev --extra tests --no-hashes --frozen --no-header --no-annotate --format requirements-txt > requirements-tests.txt
    FAILED=True
fi

REQUIREMENTS_TESTS=$(cat requirements-tests.txt)

if [ "$NEW_REQUIREMENTS_TESTS" != "$REQUIREMENTS_TESTS" ]; then
    echo "\033[0;31mFailed: requirements-tests.txt wasn't updated!\033[0m"
    uv export --no-dev --extra tests --no-hashes --frozen --no-header --no-annotate --format requirements-txt > requirements-tests.txt
    FAILED=true
fi

# docs requirements
NEW_REQUIREMENTS_DOCS=$(uv export --no-dev --extra docs --no-hashes --frozen --no-header --no-annotate)

if [ ! -f requirements-docs.txt ]; then
    echo "\033[0;31mFailed: requirements-docs.txt didn't exist!\033[0m"
    uv export --no-dev --extra docs --no-hashes --frozen --no-header --no-annotate --format requirements-txt > requirements-docs.txt
    FAILED=True
fi

REQUIREMENTS_DOCS=$(cat requirements-docs.txt)

if [ "$NEW_REQUIREMENTS_DOCS" != "$REQUIREMENTS_DOCS" ]; then
    echo "\033[0;31mFailed: requirements-docs.txt wasn't updated!\033[0m"
    uv export --no-dev --extra docs --no-hashes --frozen --no-header --no-annotate --format requirements-txt > requirements-docs.txt
    FAILED=true
fi

if [ "$FAILED" = true ]; then
    exit 1
else
    echo "All requirements' files are up to date"
    exit 0
fi
