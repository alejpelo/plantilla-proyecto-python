# Plantilla para proyectos: Python

Plantilla para organizar proyectos que usan Python e incluye las mejores prácticas relacionadas con:

- _Version control_: [git](https://git-scm.com/)
- _Virtual environments_ y _Dependency management_: [Poetry](https://python-poetry.org/)
- _Static typing_: [mypy](https://mypy-lang.org/)
- _Style enforcement_: [Flake8](https://flake8.pycqa.org/en/latest/)
- _Imports sorting_: [isort](https://pycqa.github.io/isort/)
- _Code formatting_: [Black](https://github.com/psf/black)
- _Pre-Commit hooks_: [pre-commit](https://pre-commit.com/)
- _Documentation_: [MkDocs](https://www.mkdocs.org/), [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/), [Google docstrings](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)
- _Logging_: [Loguru](https://github.com/Delgan/loguru)

## Uso

Para instalar la plantilla y empezarla a usar en un nuevo proyecto, debe tener instalado previamente en su equipo, **Git**, la versión de **Python** 3.11 y **Poetry** (en una versión superior a la 1.4).

Después de clonar este repositorio, asegúrese que _Poetry_ está usando la versión de _Python_ adecuada para crear el ambiente virtual[^1] (i.e. **3.11**) y ejecute:

```shell
poetry install
```

Eso es todo, puede empezar con su nuevo proyecto.

[^1]: [Poetry Managing Environments](https://python-poetry.org/docs/managing-environments/).
