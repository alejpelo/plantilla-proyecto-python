.PHONY: all check_environment code_type_cheking code_formatting code_linting code_vulnerability code_testing code_update_requirements

all: pre_build

update_environment:
	@printf "\033[34;1mUpdating the virtual environment => uv...\033[0m\n"
	@uv sync --upgrade --extra tests --extra docs --extra dvc --extra notebooks
	@uv sync --extra tests --extra docs
	@uv lock

pre_commit: check_environment code_type_cheking code_formatting code_linting code_vulnerability code_testing code_update_requirements

check_environment:
	@printf "\033[34;1mChecking and verifying the virtual environment => uv...\033[0m\n"
	@uv lock --locked

code_type_cheking:
	@printf "\033[34;1mType-cheking code => mypy...\033[0m\n"
	@uv run mypy

code_formatting:
	@printf "\033[34;1mFormatting code => ruff...\033[0m\n"
	@uv run ruff format

code_linting:
	@printf "\033[34;1mLinting code => ruff...\033[0m\n"
	@uv run ruff check .

code_vulnerability:
	@printf "\033[34;1mChecking vulnerabilities => pip-audit...\033[0m\n"
	@uv run pip-audit

code_testing:
	@printf "\033[34;1mTesting code => pytest...\033[0m\n"
	@uv run pytest --cov

code_update_requirements:
	@printf "\033[34;1mUpdating requirements...\033[0m\n"
	@sh write-requirements.sh
