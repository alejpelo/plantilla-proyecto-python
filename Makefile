.PHONY: all check_environment code_linting code_type_cheking code_library_sorting code_formatting code_testing code_update_requirements

all: pre_build

pre_build: check_environment code_type_cheking code_formatting code_linting code_testing code_update_requirements

check_environment:
	@printf "checking environtment => poetry...\n"
	poetry check
	poetry lock

code_type_cheking:
	@printf "type cheking code => mypy..."
	poetry run mypy

code_formatting:
	@printf "formatting code => black...\n"
	poetry run black .

code_linting:
	@printf "linting code => ruff...\n"
	poetry run ruff check .

code_testing:
	@printf "testing code => pytest...\n"
	poetry run pytest --cov

code_update_requirements:
	@printf "updating requirements...\n"
	sh write_requirements.sh
