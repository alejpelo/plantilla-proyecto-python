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

# test requirements
NEW_REQUIREMENTS_TEST=$(poetry export --format requirements.txt --without-hashes --with test)

if [ -f requirements-dev.txt ]; then
    echo "requirements-test.txt existe!"
else
    echo "Falló: requirements-test.txt no existía!"
    poetry export --format requirements.txt --output requirements-test.txt --without-hashes --with test
    FAILED=True
fi

REQUIREMENTS_TEST=$(cat requirements-test.txt)

if [ "$NEW_REQUIREMENTS_TEST" = "$REQUIREMENTS_TEST" ]; then
    echo "requirements-test.txt está actualizado!"
else
    echo "Falló: requirements-test.txt no estaba actualizado!"
    poetry export --format requirements.txt --output requirements-test.txt --without-hashes --with test
    FAILED=true
fi

# docs requirements
NEW_REQUIREMENTS_DOCS=$(poetry export --format requirements.txt --without-hashes --with docs)

if [ -f requirements-dev.txt ]; then
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
