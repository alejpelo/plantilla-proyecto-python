.PHONY: all check_environment code_type_cheking code_formatting code_linting code_vulnerability code_testing code_update_requirements

all: pre_build

update_environment:
	@printf "updating the virtual environment => poetry...\n"
	poetry update

pre_build: check_environment code_type_cheking code_formatting code_linting code_vulnerability code_testing code_update_requirements

check_environment:
	@printf "checking and verifying the virtual environment => poetry...\n"
	poetry check
	poetry lock

code_type_cheking:
	@printf "type cheking code => mypy..."
	poetry run mypy

code_formatting:
	@printf "formatting code => ruff...\n"
	poetry run ruff format

code_linting:
	@printf "linting code => ruff...\n"
	poetry run ruff check .

code_vulnerability:
	@printf "checking vulnerabilities => pip-audit...\n"
	poetry run pip-audit

code_testing:
	@printf "testing code => pytest...\n"
	poetry run pytest --cov

code_update_requirements:
	@printf "updating requirements...\n"
	sh write_requirements.sh

build: build_docs

build_docs:
	@printf "building docs => mkdocs...\n"
	poetry run mkdocs build

deploy: deploy_docs

deploy_docs:
	@printf "deploy docs => mkdocs...\n"
	poetry run mkdocs gh-deploy
