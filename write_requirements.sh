#!/bin/bash

FAILED=false

# requirements
NEW_REQUIREMENTS=$(poetry export -f requirements.txt --without-hashes)

if [ -f requirements.txt ]; then
    echo "requirements.txt existe!"
else
    echo "Falló: requirements.txt no existía!"
    poetry export --format requirements.txt --output requirements.txt --without-hashes
    FAILED=True
fi

REQUIREMENTS=$(cat requirements.txt)

if [ "$NEW_REQUIREMENTS" = "$REQUIREMENTS" ]; then
    echo "requirements.txt está actualizado!"
else
    echo "Falló: requirements.txt no estaba actualizado!"
    poetry export --format requirements.txt --output requirements.txt --without-hashes
    FAILED=True
fi

# dev requirements
NEW_REQUIREMENTS_DEV=$(poetry export --format requirements.txt --without-hashes --with dev)

if [ -f requirements-dev.txt ]; then
    echo "requirements-dev.txt existe!"
else
    echo "Falló: requirements-dev.txt no existía!"
    poetry export --format requirements.txt --output requirements-dev.txt --without-hashes --with dev
    FAILED=True
fi

REQUIREMENTS_DEV=$(cat requirements-dev.txt)

if [ "$NEW_REQUIREMENTS_DEV" = "$REQUIREMENTS_DEV" ]; then
    echo "requirements-dev.txt está actualizado!"
else
    echo "Falló: requirements-dev.txt no estaba actualizado!"
    poetry export --format requirements.txt --output requirements-dev.txt --without-hashes --with dev
    FAILED=true
fi

# tests requirements
NEW_REQUIREMENTS_TESTS=$(poetry export --format requirements.txt --without-hashes --with tests)

if [ -f requirements-tests.txt ]; then
    echo "requirements-tests.txt existe!"
else
    echo "Falló: requirements-tests.txt no existía!"
    poetry export --format requirements.txt --output requirements-tests.txt --without-hashes --with tests
    FAILED=True
fi

REQUIREMENTS_TESTS=$(cat requirements-tests.txt)

if [ "$NEW_REQUIREMENTS_TESTS" = "$REQUIREMENTS_TESTS" ]; then
    echo "requirements-tests.txt está actualizado!"
else
    echo "Falló: requirements-tests.txt no estaba actualizado!"
    poetry export --format requirements.txt --output requirements-tests.txt --without-hashes --with tests
    FAILED=true
fi

# docs requirements
NEW_REQUIREMENTS_DOCS=$(poetry export --format requirements.txt --without-hashes --with docs)

if [ -f requirements-docs.txt ]; then
    echo "requirements-docs.txt existe!"
else
    echo "Falló: requirements-docs.txt no existía!"
    poetry export --format requirements.txt --output requirements-docs.txt --without-hashes --with docs
    FAILED=True
fi

REQUIREMENTS_DOCS=$(cat requirements-docs.txt)

if [ "$NEW_REQUIREMENTS_DOCS" = "$REQUIREMENTS_DOCS" ]; then
    echo "requirements-docs.txt está actualizado!"
else
    echo "Falló: requirements-docs.txt no estaba actualizado!"
    poetry export --format requirements.txt --output requirements-docs.txt --without-hashes --with docs
    FAILED=true
fi

if [ "$FAILED" = true ]; then
    exit 1
fi
exit 0
