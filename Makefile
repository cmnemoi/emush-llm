all: install check test setup-git-hooks

check: check-format check-lint check-types

check-types:
	poetry run mypy .

check-format:
	poetry run ruff format . --diff

check-lint:
	poetry run ruff check .

install:
	poetry lock --no-update
	poetry install --with dev

lint:
	poetry run ruff format .
	poetry run ruff check . --fix

setup-git-hooks:
	chmod +x hooks/pre-commit
	chmod +x hooks/pre-push
	git config core.hooksPath hooks

test:
	poetry run pytest -v --cov=emush_llm

.PHONY: all check check-format check-lint install lint test