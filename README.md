# Plantilla para proyectos: Python

Click [aquí](https://alejpelo.github.io/plantilla-proyecto-python/) para ver la documentación en línea

<!--docs-start-->

Plantilla para organizar proyectos que usan Python e incluye las mejores prácticas relacionadas con:

- _Version control_: [Git](https://git-scm.com/)
- _Virtual environments_ y _Dependency management_: [Poetry](https://python-poetry.org/)
- _Static typing_: [Mypy](https://mypy-lang.org/)
- _Code formatting_: [Black](https://github.com/psf/black)
- _Linting_ and _Style enforcement_: [Ruff](https://beta.ruff.rs/docs/)
- _Package vulnerability analysis_: [Pip-audit](https://pypi.org/project/pip-audit/)
- _Pre-Commit hooks_: [Pre-commit](https://pre-commit.com/)
- _Documentation_: [MkDocs](https://www.mkdocs.org/), [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/), [Google docstrings](https://google.github.io/styleguide/pyguide.html#38-comments-and-docstrings)
- Configuration files: [Hydra](https://hydra.cc/)
- _Logging_: [Loguru](https://github.com/Delgan/loguru)

## Uso

Para instalar la plantilla y empezarla a usar en un nuevo proyecto, debe tener instalado previamente en su equipo, [**Git**](https://git-scm.com/), [**Python**](https://www.python.org/)[^1] (versión 3.11) y [**Poetry**](https://python-poetry.org/) (versión >=1.5).

1. Cree un _fork_ de este repositorio. Si ya tenía el _fork_, realice un _sync fork_ para traer la versión más reciente. Otra opción es crear un nuevo repositorio a partir de este, para el nuevo proyecto.
2. Clone el nuevo repositorio.
3. Asegúrese que _Poetry_ está usando la versión de _Python_ adecuada para crear el ambiente virtual[^2] (i.e. 3.11) y ejecute:

    ```shell
    poetry install
    ```

4. En el proyecto se usa [pre-commit](https://pre-commit.com/) para automatizar la verificación del código antes de los _commits_ y de los _pushs_. La librería ya está incluida en las dependencias necesarias para contribuir al proyecto, sin embargo, es necesario configurarla usando las siguientes instrucciones:

    ```shell
    pre-commit install
    pre-commit install --hook-type pre-push
    ```

5. Consulte el archivo `src/proyecto/tutorial.py` para conocer cómo usar los archivos de configuración y el log.

6. Consulte el archivo `docs/tutorial.md` para conocer las capacidades instaladas de la documentación. Para trabajar en la documentación, con el ambiente virtual activado, ejecute:

    ```shell
    mkdocs serve
    ```

    Esto hará que la documentación en se actualice en la medida que realice cambios.

    Al final para construir el sitio, ejecute:

    ```shell
    mkdocs build
    ```

    Y para deplegar la documentación en el [GitHub Pages](https://pages.github.com/), estando en la **master**/**main** _branch_, ejecute:

    !!! warning
        Para que esta instrucción funcione y la página quede publicada, el repositorio debe ser público o el usuario debe estar suscrito a [GitHub Teams](https://github.com/team)

    ```shell
    mkdocs gh-deploy
    ```

!!! danger
    El proyecto tiene un makefile y un archivo shell que no corren en Windows por defecto. En Linux y MacOS funciona correctamente. En Windows, por el momento, es necesario remover el pre-commit que exporta los archivos de librarías requeridas de `.pre-commit-config.yaml`. y no usar el `Makefile`.
    Próximamente se incluirán las instrucciones para que todo funcione adecuadamente en Windows.

Eso es todo, puede empezar con su nuevo proyecto.

## Librarías útiles para los proyectos

- [Pandas](https://pandas.pydata.org/)
- [Polars](https://www.pola.rs/)
- [Pydantic](https://docs.pydantic.dev/latest/)
- [Scikit-learn](https://scikit-learn.org/stable/)
- [Keras](https://keras.io/)

- [Streamlit](https://streamlit.io/)
- [DearPyGUI](https://github.com/hoffstadt/DearPyGui)
- [Gradio](https://github.com/gradio-app/gradio)

- [FastAPI](https://fastapi.tiangolo.com/lo/)

- [Power tools for AWS Lambda](https://awslabs.github.io/aws-lambda-powertools-python/2.16.1/)

- [Nox](https://nox.thea.codes/en/stable/index.html)

Para instalar una de estas librerías, o cualquier otra que vaya a utilizar, haciendo uso de **Poetry**, se debe ejecutar, por ejemplo:

```shell
poetry add pandas
```

Si la va a instalar solo para desarrollo, o en cualquier otro grupo de librerías, ejecutar:

```shell
poetry add nox --group dev
```

## Lineamientos para Contribuir al Proyecto

Se deben seguir los siguientes lineamientos para para contribuir al desarrollo del proyecto. Esto garantiza que la trazabilidad y el versionamiento sea robusto.

### _Workflow_

Se utiliza [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow) con la siguiente estructura de _branches_:

- **master**/**main** _branch_: solo guarda los _releases_ oficiales. Cada _release_ debe estar identificado con su respectivo _tag_ que hace alusión a la versión del código (ver Versionamiento (_tags_)).

- **develop** _branch_: funciona como integrador de los distintos ajustes, cambios, correcciones, mejoras o adiciones (_bug fixes_ o _features_) que se están desarrollando. Este es el _branch_ del que se deben crear los _forks_ para desarrollar correcciones, mejoras o adiciones en el código.

- **bugfix/** _branches_: Cada corrección debe residir en su propio _branch_. Siempre se deben crear a partir del **develop** _branch_.

- **feature/** _branches_: Cada nuevo cambio, mejora o adición debe residir en su propio _branch_. Siempre se deben crear a partir del **develop** _branch_.

- **release/** _branches_: Cuando se tienen acumulados varios cambios, mejoras, correcciones y/o adiciones, se crea un _branch_ de este tipo desde el **develop** _branch_. Esto inicia el ciclo de _release_ y a partir de este momento no se pueden añadir nuevas mejoras o cambios al código, en este _branch_, que no estén relacionadas con la corrección de errores, la documentación o tareas específicas orientadas al proceso de _release_.

- **hotfix/** _branches_: Usadas para reparar rápidamente errores en la versión de producción (**master** _branch_). Este es el único _branch_ que se puede (y debe) crear a partir del **master** _branch_. Una vez terminada la corrección se fusiona nuevamente con el **master** _branch_, con el **release-** _branch_ actual y con el **develop** _branch_. La fusión con el **master** _branch_ debe llevar su respectiva **tag** con el número de versión actualizado.

### _Commits_

Es obligatorio incluir un mensaje en cada _commit_. El mensaje debe utilizar la siguiente plantilla:

```git
<tipo>: <asunto> (Si se aplica, este commit...)
|<----  Usar máximo 50 caracteres  ---->|

Explique por qué se realiza el cambio.
|<----  Trate de limitar cada línea a máximo 72 caracteres  ---->|

Provea links o claves a cualquier ticket, artículo u otro recurso relevante para el commit
Ejemplo: Issue #23

---- FIN DEL COMMIT ----

Type can be: 
    feat     nueva característica
    fix      corrección de error
    style    formato (e.g. agregar comas que faltaban); no se cambia el código
    docs     cambios a la documentación
    test     añadir o ajustar tests; no se cambia el código de producción
    chore    cambia configuración CI/CD, pre-commits, etc.; no se cambia el código de producción

---------------

Recuerde...
    Empezar con mayúscula la línea del asunto
    Usar el modo imperativo en la línea del asunto
    No terminar la línea del asunto con punto
    Separar la línea del asunto del cuerpo del commit (descripción) con una línea en blanco
    Usar el cuerpo del commit para explicar el qué y el por qué, no el cómo
    Puede usar múltiple líneas con "-" para viñetas en el cuerpo del commit
```

### Versionamiento (_tags_)

Se usa [SemVer](http://semver.org/) como lineamiento para el versionamiento. Para nombrar las **_tags_** se debe usar la forma `v0.0.0`.

Para ver las versiones disponibles, consulte las [_tags_ en este repositorio](https://github.com/alejpelo/plantilla-proyecto-python/tags).

---

[^1]: Para instalar Python se recomienda usar [pyenv](https://github.com/pyenv/pyenv) para Linux o MacOS. En Windows la recomendación es instalar Python con el instalador que se encuentra en la página oficial.

[^2]: [Poetry Managing Environments](https://python-poetry.org/docs/managing-environments/).

<!--docs-end-->
